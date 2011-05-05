require 'netzke/railz/action_view_ext/ext'
require 'netzke/railz/action_view_ext/touch'
module Netzke
  module Railz
    module ActionViewExt
      include Ext
      include Touch

      # A helper to initialize Netzke. Usually used in the layout.
      #
      # Params:
      # * :platform - :ext or :touch, by default :ext
      # * :theme - the name of theme to apply
      # * :cache - enable Rails caching of assets
      #
      # E.g.:
      #     <%= netzke_init :theme => :grey %>
      #
      # For Sencha Touch:
      #     <%= netzke_init :platform => :touch %>
      def netzke_init(params = {})
        Netzke::Core.platform = params[:platform] || :ext
        theme = params[:theme] || params[:ext_theme]

        # Rails' forgery protection
        content_for :netzke_js_classes, %Q(\n\nExt.Ajax.extraParams = {authenticity_token: '#{form_authenticity_token}'};)

        raw([netzke_css_include(params), netzke_css(params), netzke_js_include(params), netzke_js(params)].join("\n"))
      end

      # Use this helper in your views to embed Netzke components. E.g.:
      #     netzke :my_grid, :class_name => "Basepack::GridPanel", :columns => [:id, :name, :created_at]
      def netzke(name, config = {})
        @rendered_classes ||= []

        # If we are the first netzke call on the page, reset components hash in the session.
        # WON'T WORK, because it breaks the browser "back" button
        # if @rendered_classes.empty?
        #   Netzke::Core.reset_components_in_session
        # end

        class_name = config[:class_name] ||= name.to_s.camelcase

        config[:name] = name

        # Register the component in session
        Netzke::Core.reg_component(config)

        cmp = Netzke::Base.instance_by_config(config)
        cmp.before_load # inform the component about initial load

        content_for :netzke_js_classes, raw(cmp.js_missing_code(@rendered_classes))

        content_for :netzke_css, raw(cmp.css_missing_code(@rendered_classes))

        content_for :netzke_on_ready, raw("#{cmp.js_component_instance}\n\n#{cmp.js_component_render}")

        # Now mark this component's class as rendered (by storing it's xtype), so that we only generate it once per view
        @rendered_classes << class_name.to_s.gsub("::", "").downcase unless @rendered_classes.include?(class_name)

        # Return the html for this component
        raw(cmp.js_component_html)
      end

      protected

        # Link tags for all the required stylsheets
        def netzke_css_include(params)
          send :"netzke_#{Netzke::Core.platform}_css_include", params
        end

        # Inline CSS specific for the page
        def netzke_css(params)
          %{
    <style type="text/css" media="screen">
      #{content_for(:netzke_css)}
    </style>} if content_for(:netzke_css).present?
        end

        # Script tags for all the required JavaScript
        def netzke_js_include(params)
          send :"netzke_#{Netzke::Core.platform}_js_include", params
        end

        # Inline JavaScript for all Netzke classes on the page, as well as Ext.onReady (Ext.setup in case of Touch) which renders Netzke components in this view after the page is loaded
        def netzke_js(params = {})
          send :"netzke_#{Netzke::Core.platform}_js", params
        end

    end

  end
end
