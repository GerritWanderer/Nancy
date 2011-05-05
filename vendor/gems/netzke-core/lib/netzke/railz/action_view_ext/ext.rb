module Netzke
  module Railz
    module ActionViewExt
      # Implementation of Ext-specific helpers
      module Ext #:nodoc:

        protected

          def netzke_ext_css_include(params)
            # ExtJS base
            res = ["/extjs/resources/css/ext-all"]

            # ExtJS theming
            res << "/extjs/resources/css/xtheme-#{params[:theme]}" if params[:theme]

            # Netzke-related dynamic css
            res << "/netzke/ext"

            res += Netzke::Core.external_ext_css

            stylesheet_link_tag(res, :cache => false && params[:cache]) # caching is not possible at this time, as the stylesheets use relative asset paths
          end

          def netzke_ext_js_include(params)
            # ExtJS stuff
            res = if ENV['RAILS_ENV'] == 'development'
              [
                "/extjs/adapter/ext/ext-base-debug",
                "/extjs/ext-all-debug"
              ]
            else
              [
                "/extjs/adapter/ext/ext-base",
                "/extjs/ext-all"
              ]
            end

            # Netzke-related dynamic JavaScript
            res << "/netzke/ext"

            javascript_include_tag(res, :cache => params[:cache])
          end

          def netzke_ext_js(params)
            res = []
            res << content_for(:netzke_js_classes)
            res << "\n"

            res << "Ext.onReady(function(){"
            res << content_for(:netzke_on_ready)
            res << "});"

            javascript_tag(res.join("\n"))
          end

          # (Experimental) Embeds a "pure" (non-Netzke) Ext component into the view, e.g.:
          #     <%= ext :my_panel, :xtype => :panel, :html => "Simple Panel"
          def ext(name, config = {}) #:doc:
            comp = Netzke::ExtComponent.new(name, config)
            content_for :netzke_on_ready, raw("#{comp.js_component_render}")
            raw(comp.js_component_html)
          end

      end
    end
  end
end
