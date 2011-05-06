// Because of Netzke's double-underscore notation, Ext.TabPanel should have a different id-delimiter (yes, this should be in netzke-core)
Ext.TabPanel.prototype.idDelimiter = "___";

Ext.QuickTips.init();

// We don't want no state managment by default, thank you!
Ext.state.Provider.prototype.set = function(){};

// Check Ext JS version
(function(){
  var requiredExtVersion = "3.3.1";
  var currentExtVersion = Ext.version;
  if (requiredExtVersion !== currentExtVersion) {
    Netzke.deprecationWarning("Need Ext " + requiredExtVersion + ". You have " + currentExtVersion + ".");
  }
})();

Netzke.classes.NetzkeRemotingProvider = Ext.extend(Ext.direct.RemotingProvider, {
  getCallData: function(t){
    return {
      act: t.action, // rails doesn't really support having a parameter named "action"
      method: t.method,
      data: t.data,
      type: 'rpc',
      tid: t.tid
    }
  },

  addAction: function(action, methods) {
    var cls = this.namespace[action] || (this.namespace[action] = {});
    for(var i = 0, len = methods.length; i < len; i++){
        var m = methods[i];
        cls[m.name] = this.createMethod(action, m);
      }
  },

  // process response regardess of status
  // i.e. in a batch request,
  // - we request tids 1,2,3.
  // - server is able to process 1 but not 2
  // - server will stop and *not* process 3, because it could be dependant on 2 (this best possible approach to this
  //   situation, as we don't have transactions)
  // - server will respond with status 500, indicating a fault
  // - in the response, server will respond with the result from tid 1
  // - client marks tid 1 as success (deletes the transaction from pending), and will retry 2 and 3 - this is the
  //   change in Ext.direct.RemotingProvider's default behaviour
  onData: function(opt, success, xhr){
    var events=this.getEvents(xhr);

    for(var i = 0, len = events.length; i < len; i++){
      var e = events[i],
      t = this.getTransaction(e);
      this.fireEvent('data', this, e);
      if(t){
        this.doCallback(t, e, true);
        Ext.Direct.removeTransaction(t);
      }
    }

    Netzke.classes.NetzkeRemotingProvider.superclass.onData.call(this, opt, success, xhr);
  }

});

Netzke.directProvider = new Netzke.classes.NetzkeRemotingProvider({
  "type": "remoting",       // create a Ext.direct.RemotingProvider
  "url": Netzke.RelativeUrlRoot + "/netzke/direct/", // url to connect to the Ext.Direct server-side router.
  "namespace": "Netzke.providers", // namespace to create the Remoting Provider in
  "actions": {},
  "maxRetries": Netzke.core.directMaxRetries,
  "enableBuffer": true, // buffer/batch requests within 10ms timeframe
  "timeout": 30000 // 30s timeout per request
});

Ext.Direct.addProvider(Netzke.directProvider);

Ext.apply(Netzke.classes.Core.Mixin, {
  height: 400,
  border: false,

  /*
  Mask shown during loading of a component. Set to false to not mask. Pass config for Ext.LoadMask for configuring msg/cls, etc.
  Set msg to null if mask without any msg is desirable.
  */
  componentLoadMask: true,

  /* initComponent common for all Netzke components */
  initComponentWithNetzke: function(){
    this.normalizeActions();

    this.detectActions(this);

    this.detectComponents(this.items);

    this.normalizeTools();

    this.processEndpoints();

    // This is where the references to different callback functions will be stored
    this.callbackHash = {};

    // This is where we store the information about components that are currently being loaded with this.loadComponent()
    this.componentsBeingLoaded = {};

    // Set title
    if (this.mode === "config"){
      if (!this.title) {
        this.title = '[' + this.id + ']';
      } else {
        this.title = this.title + ' [' + this.id + ']';
      }
    } else {
      if (!this.title) {
        this.title = this.id.humanize();
      }
    }

    // Call the original initComponent
    this.initComponentWithoutNetzke();
  },

  /*
  Dynamically creates methods for endpoints, so that we could later call them like: this.myEndpointMethod() (using Ext.Direct)
  */
  processEndpoints: function(){
    var endpoints = this.endpoints || [];
    endpoints.push('deliver_component'); // all Netzke components get this endpoint
    var directActions = [];
    var that=this;

    Ext.each(endpoints, function(intp){
      directActions.push({"name":intp.camelize(true), "len":1});
      this[intp.camelize(true)] = function(arg, callback, scope) {
        Netzke.runningRequests++;
        scope=scope || that;
        Netzke.providers[this.id][intp.camelize(true)].call(typeof scope != 'undefined' ? scope : that, arg, function(result, remotingEvent) {
          if(remotingEvent.message) {
            console.error("RPC event indicates an error: ", remotingEvent);
            throw new Error(remotingEvent.message);
          }
          that.bulkExecute(result); // invoke the endpoint result on the calling component
          if(typeof callback == "function") {
            callback.call(scope, that.latestResult); // invoke the callback on the provided scope, or on the calling component if no scope set. Pass latestResult to callback
          }
          Netzke.runningRequests--;
        });
      }
    }, this);

    Netzke.directProvider.addAction(this.id, directActions);
  },

  normalizeTools: function() {
    if (this.tools) {
      var normTools = [];
      Ext.each(this.tools, function(tool){
        // Create an event for each action (so that higher-level components could interfere)
        this.addEvents(tool.id+'click');

        var handler = this.toolActionHandler.createDelegate(this, [tool]);
        normTools.push({id : tool, handler : handler, scope : this});
      }, this);
      this.tools = normTools;
    }
  },

  /*
  Replaces actions configs with Ext.Action instances, assigning default handler to them
  */
  normalizeActions : function(){
    var normActions = {};
    for (var name in this.actions) {
      // Create an event for each action (so that higher-level components could interfere)
      this.addEvents(name+'click');

      // Configure the action
      var actionConfig = Ext.apply({}, this.actions[name]); // do not modify original this.actions
      actionConfig.customHandler = actionConfig.handler;
      actionConfig.handler = this.actionHandler.createDelegate(this); // handler common for all actions
      actionConfig.name = name;
      normActions[name] = new Ext.Action(actionConfig);
    }
    delete(this.actions);
    this.actions = normActions;
  },

  /*
  Detects action configs in the passed object, and replaces them with instances of Ext.Action created by normalizeActions().
  This detects action in arbitrary level of nesting, which means you can put any other components in your toolbar, and inside of them specify menus/items or even toolbars.
  */
  detectActions: function(o){
    if (Ext.isObject(o)) {
      if ((typeof o.handler === 'string') && Ext.isFunction(this[o.handler.camelize(true)])) {
         // This button config has a handler specified as string - replace it with reference to a real function if it exists
        o.handler = this[o.handler.camelize(true)].createDelegate(this);
      }
      // TODO: this should be configurable!
      Ext.each(["bbar", "tbar", "fbar", "menu", "items", "contextMenu", "buttons"], function(key){
        if (o[key]) {
          var items = [].concat(o[key]); // we need to do it in order to esure that this instance has a separate bbar/tbar/etc, NOT shared via class' prototype
          delete(o[key]);
          o[key] = items;
          this.detectActions(o[key]);
        }
      }, this);
    } else if (Ext.isArray(o)) {
      var a = o;
      Ext.each(a, function(el, i){
        if (Ext.isObject(el)) {
          if (el.action) {
            if (!this.actions[el.action.camelize(true)]) throw "Netzke: action '"+el.action+"' not defined";
            a[i] = this.actions[el.action.camelize(true)];
            delete(el);
          } else {
            this.detectActions(el);
          }
        }
      }, this);
    }
  },

  /*
  Loads a component. Config options:
  'name' (required) - the name of the child component to load
  'container' - the id of a panel with the 'fit' layout where the loaded component will be instantiated
  'callback' - function that gets called after the component is loaded. It receives the component's instance as parameter.
  'scope' - scope for the callback.
  */
  loadComponent: function(params){
    if (params.id) {
      params.name = params.id;
      Netzke.deprecationWarning("Using 'id' in loadComponent is deprecated. Use 'name' instead.");
    }

    params.name = params.name.underscore();

    // params that will be provided for the server API call (deliver_component); all what's passed in params.params is merged in. This way we exclude from sending along such things as :scope, :callback, etc.
    var serverParams = params.params || {};
    serverParams.name = params.name;

    // coma-separated list of xtypes of already loaded classes
    serverParams.cache = Netzke.cache.join();

    var storedConfig = this.componentsBeingLoaded[params.name] = {};

    // Remember where the loaded component should be inserted into
    if (params.container) {
      storedConfig.container = params.container;
    }

    // remember the passed callback for the future (per loaded component, as there may be simultaneous ongoing calls)
    if (params.callback) {
      storedConfig.callback = params.callback;
      storedConfig.scope = params.scope;
      // this.callbackHash[params.name.underscore()] = params.callback;
    }

    var container = params.container && Ext.getCmp(params.container);
    if (container) {
      // remove the old component if the container is specified
      container.removeChild();
    }

    // Show loading mask if possible
    var containerEl = (container || this).getEl();
    if (this.componentLoadMask && containerEl){
      storedConfig.loadMaskCmp = new Ext.LoadMask(containerEl, this.componentLoadMask);
      storedConfig.loadMaskCmp.show();
    }

    // do the remote API call
    this.deliverComponent(serverParams);
  },

  /*
  Called by the server after we ask him to load a component
  */
  componentDelivered : function(config){
    // retrieve the loading config for this component
    var storedConfig = this.componentsBeingLoaded[config.name] || {};
    delete this.componentsBeingLoaded[config.name];

    if (storedConfig.loadMaskCmp) {
      storedConfig.loadMaskCmp.hide();
      storedConfig.loadMaskCmp.destroy();
    }

    // instantiate and render it
    var componentInstance = this.instantiateAndRenderComponent(config, storedConfig.container);

    if (storedConfig.callback) {
      storedConfig.callback.call(storedConfig.scope || this, componentInstance);
    }

    this.fireEvent('componentload', componentInstance);
  },

  /*
  Instantiates and renders a component with given config and container
  */
  instantiateAndRenderComponent : function(config, containerId){
    var componentInstance;
    if (containerId) {
      var container = Ext.getCmp(containerId);
      componentInstance = container.instantiateChild(config);
    } else {
      componentInstance = this.instantiateChild(config);
    }
    return componentInstance;
  },

  /*
  Instantiates and inserts a component into a container with layout 'fit'.
  Arg: an JS object with the following keys:
    - id: id of the receiving container
    - config: configuration of the component to be instantiated and inserted into the container
  */
  // renderComponentInContainer : function(params){
  //   var cont = Ext.getCmp(params.container);
  //   if (cont) {
  //     cont.instantiateChild(params.config);
  //   } else {
  //     this.instantiateChild(params.config);
  //   }
  // },

  /*
  Returns the parent component
  */
  getParent: function(){
    // simply cutting the last part of the id: some_parent__a_kid__a_great_kid => some_parent__a_kid
    var idSplit = this.id.split("__");
    idSplit.pop();
    var parentId = idSplit.join("__");

    return parentId === "" ? null : Ext.getCmp(parentId);
  },

  /*
  Reloads current component (calls the parent to reload it as its component)
  */
  reload : function(){
    var parent = this.getParent();
    if (parent) {
      parent.loadComponent({id:this.localId(parent), container:this.ownerCt.id});
    } else {
      window.location.reload();
    }
  },

  /*
  Reconfigures the component
  */
  reconfigure: function(config){
    this.ownerCt.instantiateChild(config)
  },

  // Get the child component
  getChildComponent : function(id){
    if (id === "") {return this};
    id = id.underscore();
    var split = id.split("__");
    if (split[0] === 'parent') {
      split.shift();
      var childInParentScope = split.join("__");
      return this.getParent().getChildComponent(childInParentScope);
    } else {
      return Ext.getCmp(this.id+"__"+id);
    }
  },

  // At this moment component is fully initializied
  commonAfterConstructor : function(config){

    // Add the menus
    if (this.initialConfig.menu) {this.addMenu(this.initialConfig.menu, this);}

    // generic events
    this.addEvents(
      'componentload' // fired when a child is dynamically loaded
    );

    // Cleaning up on destroy
    this.on('beforedestroy', function(){
      this.cleanUpMenu();
    }, this);

    this.callbackHash = {};

    if (this.afterConstructor) this.afterConstructor(config);
  },

  feedback:function(msg){
    if (this.initialConfig && this.initialConfig.quiet) {
      return false;
    }

    if (this.feedbackGhost) {
      this.feedbackGhost.showFeedback(msg);
    } else {
      // there's no application to show the feedback - so, we do it ourselves
      if (typeof msg == 'string'){
        alert(msg);
      } else {
        var compoundResponse = "";
        Ext.each(msg, function(m){
          compoundResponse += m.msg + "\n"
        });
        if (compoundResponse != "") {
          alert(compoundResponse);
        }
      }
    }
  },

  // Common handler for all component's actions. <tt>comp</tt> is the Component that triggered the action (e.g. button or menu item)
  actionHandler : function(comp){
    var actionName = comp.name;
    // If firing corresponding event doesn't return false, call the handler
    if (this.fireEvent(actionName+'click', comp)) {
      var action = this.actions[actionName];
      var customHandler = action.initialConfig.customHandler;
      var methodName = (customHandler && customHandler.camelize(true)) || "on" + actionName.camelize();
      if (!this[methodName]) {throw "Netzke: action handler '" + methodName + "' is undefined"}

      // call the handler passing it the triggering component
      this[methodName](comp);
    }
  },

  // Common handler for tools
  toolActionHandler : function(tool){
    // If firing corresponding event doesn't return false, call the handler
    if (this.fireEvent(tool.id+'click')) {
      var methodName = "on"+tool.camelize();
      if (!this[methodName]) {throw "Netzke: handler for tool '"+tool+"' is undefined"}
      this[methodName]();
    }
  },

  onComponentLoad:Ext.emptyFn // gets overridden
});
