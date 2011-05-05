require 'active_support/core_ext'
require 'active_support/memoizable'
require 'netzke/core_ext'
require 'netzke/javascript'
require 'netzke/stylesheets'
require 'netzke/inheritance'
require 'netzke/services'
require 'netzke/composition'
require 'netzke/configuration'
require 'netzke/state'
require 'netzke/embedding'
require 'netzke/actions'
require 'netzke/session'

module Netzke
  # The base for every Netzke component
  #
  # == Class-level configuration
  # You can configure component classes in Rails Application, e.g.:
  #
  #     config.netzke.basepack.grid_panel.column_filters_available = false
  #
  # Optionally, when used outside of Rails, you can also set the values directly on Netzke::Core.config (the Engine does it for you):
  #
  #     Netzke::Core.config.netzke.basepack.grid_panel.column_filters_available = false
  #
  # If both default and overriding values are hashes, the default value gets deep-merged with the overriding value.
  #
  # Netzke::Base provides the following class-level configuration options:
  # * default_instance_config - a hash that will be used as default configuration for ALL of this component's instances.
  class Base
    include Session
    include State
    include Configuration
    include Javascript
    include Inheritance
    include Services
    include Composition
    include Stylesheets
    include Embedding
    include Actions

    class_config_option :default_instance_config, {}

    # Parent component
    attr_reader :parent

    # Name that the parent can reference us by. The last part of +global_id+
    attr_reader :name

    # Global id in the components tree, following the double-underscore notation, e.g. +books__config_panel__form+
    attr_reader :global_id

    class << self
      extend ActiveSupport::Memoizable

      # Component's short class name, e.g.:
      # "Netzke::Module::SomeComponent" => "Module::SomeComponent"
      def short_component_class_name
        self.name.sub(/^Netzke::/, "")
      end

      # Component's class, given its name.
      # Note: this method will be memoized if Rails.configuration.cache_classes is true.
      def constantize_class_name(class_name)
        "#{class_name}".constantize
      rescue NameError
        begin
          "Netzke::#{class_name}".constantize
        rescue NameError
          nil
        end
      end

      # Instance of component by config
      def instance_by_config(config)
        (config[:klass] || constantize_class_name(config[:class_name])).new(config)
      end

      # The ID used to locate this component's block in locale files
      def i18n_id
        name.split("::").map{|c| c.underscore}.join(".")
      end

    end

    # Instantiates a component instance. A parent can optionally be provided.
    def initialize(conf = {}, parent = nil)
      @passed_config = conf # configuration passed at the moment of instantiation
      @passed_config.deep_freeze
      @parent        = parent
      @name          = conf[:name].nil? ? short_component_class_name.underscore : conf[:name].to_s
      @global_id     = parent.nil? ? @name : "#{parent.global_id}__#{@name}"
      @flash         = []

      # initialize @components and @items
      normalize_components_in_items
      # auto_collect_actions_from_config_and_js_properties

      self.class.increase_total_instances
    end

    # Proxy to the equally named class method
    def constantize_class_name(class_name)
      self.class.constantize_class_name(class_name)
    end

    # Proxy to the equally named class method
    def short_component_class_name
      self.class.short_component_class_name
    end

    # Override this method to do stuff at the moment of first-time loading
    def before_load
    end

    def clean_up
      component_session.clear
      components.keys.each { |k| component_instance(k).clean_up }
    end

    def i18n_id
      self.class.i18n_id
    end

    # Used for performance measurments
    def self.total_instances
      @@instances || 0
    end

    def self.reset_total_instances
      @@instances = 0
    end

    def self.increase_total_instances
      @@instances ||= 0
      @@instances += 1
    end

    private

      def logger #:nodoc:
        if defined?(::Rails)
          ::Rails.logger
        else
          require 'logger'
          Logger.new(STDOUT)
        end
      end

      def flash(flash_hash) #:nodoc:
        level = flash_hash.keys.first
        raise "Unknown message level for flash" unless %(notice warning error).include?(level.to_s)
        @flash << {:level => level, :msg => flash_hash[level]}
      end

  end
end
