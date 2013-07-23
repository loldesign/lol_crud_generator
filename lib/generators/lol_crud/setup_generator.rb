module LolCrud
  class SetupGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def add_shared_specs
      copy_file "spec/support/crud/post_create.rb"    , "spec/support/crud/post_create.rb"
      copy_file "spec/support/crud/put_update.rb"     , "spec/support/crud/put_update.rb"
      copy_file "spec/support/crud/get_edit.rb"       , "spec/support/crud/get_edit.rb"
      copy_file "spec/support/crud/get_index.rb"      , "spec/support/crud/get_index.rb"
      copy_file "spec/support/crud/delete_destroy.rb" , "spec/support/crud/delete_destroy.rb"
      copy_file "spec/support/crud/get_new.rb"        , "spec/support/crud/get_new.rb"
      copy_file "spec/support/crud/get_show.rb"       , "spec/support/crud/get_show.rb"
    end
  end
end