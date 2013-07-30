module LolCrud
  class CrudGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    argument :resource_name, :required => true, :default => nil

    class_option :namespace, :desc => "Generate crud in Namespace", :type => :string, :default => ''

    def create_routes
      @settings = resource_options

      sentinel  = has_namespace? ? /#{@settings[:namespace]} do\s*$/ : /\.routes\.draw do\s*$/
      
      log :route, "#{@settings[:namespace]}/#{@settings[:assigns_plural]}"

      inject_into_file 'config/routes.rb', route_name() , { after: sentinel, verbose: false}
    end

    def create_controller
      @settings = resource_options

      template "controllers/controller.rb", "app/controllers/#{file_path()}_controller.rb"
    end

    def create_views
      @settings = resource_options

      template  "views/index.html.erb",    "app/views/#{file_path()}/index.html.erb"
      template  "views/_form.html.erb",    "app/views/#{file_path()}/_form.html.erb"
      template  "views/show.html.erb",     "app/views/#{file_path()}/show.html.erb"
      template  "views/_object.html.erb",  "app/views/#{file_path()}/_#{@settings[:assigns]}.html.erb"
      copy_file "views/new.html.erb",      "app/views/#{file_path()}/new.html.erb"
      copy_file "views/edit.html.erb",     "app/views/#{file_path()}/edit.html.erb"
      copy_file "views/_no_data.html.erb", "app/views/#{file_path()}/_no_data.html.erb"
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
        form_url:       form_for_url
      }
    end

    def has_namespace?
      options.namespace.present?
    end

    def route_name
      identation = has_namespace? ? "\n    " : "\n  "
      
      "#{identation}resources :#{@settings[:assigns_plural]}"
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

    def form_for_url
      form_for = "@#{resource_name.classify.underscore}"

      return "[:#{options.namespace}, #{form_for}]" if has_namespace?

      form_for
    end
  end
end
