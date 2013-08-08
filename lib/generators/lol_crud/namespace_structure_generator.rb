module LolCrud
	class NamespaceStructureGenerator < Rails::Generators::Base
		source_root File.expand_path('../templates', __FILE__)

		argument :name, :required => true, :default => nil

		def add_in_routes
			route "\n  namespace :#{name} do \n  end"
		end

		def add_controller
			@settings = namespace_options

			template  "controllers/namespace/namespace_controller.rb", "app/controllers/#{@settings[:name]}/#{@settings[:name]}_controller.rb"
		end

		def add_layout
			@settings = namespace_options

			template  "views/layouts/namespace/namespace.html.erb"								, "app/views/layouts/#{@settings[:name]}/#{@settings[:name]}.html.erb"
			copy_file "views/layouts/namespace/_header.html.erb"  								, "app/views/layouts/#{@settings[:name]}/_header.html.erb"
			copy_file "views/layouts/namespace/_flash.html.erb"   								, "app/views/layouts/#{@settings[:name]}/_flash.html.erb"
			copy_file "assets/javascripts/#{@settings[:name]}/namespace.js"       , "app/assets/javascripts/#{@settings[:name]}.js"
			copy_file "assets/stylesheets/#{@settings[:name]}/namespace.css.scss" , "app/assets/stylesheets/#{@settings[:name]}.css.scss"
		end

		private
    def namespace_options
      {
        name:           name,
        model:          name.classify
      }
    end
	end
end

