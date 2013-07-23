#encoding: utf-8
shared_examples 'CRUD GET index' do |options|
  let!(:model_name)                   { options[:resource].classify            }
  let!(:model_klass)                  { model_name.constantize                 }
  let!(:model_name_pluralized)        { model_name.humanize.pluralize          }
  let!(:assigns_model_name)           { model_name.underscore.to_sym           }
  let!(:pluralized_assigns_model_name){ model_name.underscore.pluralize.to_sym }
  let!(:resource)                     { options[:resource_is_current_user] ? current_user : create(options[:resource]) }

  describe "#index" do
    before { get :index }

    it{ response.should render_template :index }
    it{ assigns[pluralized_assigns_model_name].should == [resource] }
  end
end