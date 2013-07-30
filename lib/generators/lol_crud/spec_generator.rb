module LolCrud
  class SpecGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    argument :resource_name, :required => true, :default => nil

    class_option :namespace , :desc => "Generate spec with Namespace", :type => :string, :default => ''
    class_option :need_login, :desc => "Add Login in Specs", :type => :string, :default => false

    def create_spec
      @settings = resource_options
      
      template "spec/controllers/controller_spec.rb", "spec/controllers/#{file_path()}_controller_spec.rb"
    end

    private
    def resource_options
      {
        name:           resource_name,
        model:          resource_name.classify,
        klass:          resource_name.classify.constantize,
        controller:     controller_name,
        plural:         resource_name.classify.pluralize.downcase,
        assigns:        resource_name.classify.underscore,
        assigns_plural: resource_name.classify.underscore.pluralize,
        model_fields:   resource_name.classify.constantize.fields.keys,
        namespace:      options.namespace,
        path_prefix:    path_prefix,
        need_login:     options.need_login || options.namespace.present?
      }
    end

    def has_namespace?
      options.namespace.present?
    end

    def controller_name
      klass = resource_name.classify.pluralize

      return "#{options.namespace.classify}::#{klass}" if has_namespace?

      klass
    end

    def file_path
      path = @settings[:assigns_plural]

      return "#{@settings[:namespace]}/#{path}" if has_namespace?

      path 
    end

    def path_prefix
      prefix = ""

      return "#{options.namespace}_" if has_namespace?

      prefix
    end
  end
end