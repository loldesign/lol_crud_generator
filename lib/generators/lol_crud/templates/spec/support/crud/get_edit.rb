#encoding: utf-8
shared_examples 'CRUD GET edit' do |options|
  let!(:model_name)                   { options[:resource].classify            }
  let!(:model_klass)                  { model_name.constantize                 }
  let!(:model_name_pluralized)        { model_name.humanize.pluralize          }
  let!(:assigns_model_name)           { model_name.underscore.to_sym           }
  let!(:pluralized_assigns_model_name){ model_name.underscore.pluralize.to_sym }
  let!(:resource)                     { options[:resource_is_current_user] ? current_user : mock_model(model_klass) }
  
  before{ resource.stub(options[:parent_attr_name] || :user_id).and_return(current_user.id) if options[:has_parent] }

  describe "GET edit" do
    before do
      model_klass.should_receive(:find).and_return(resource)
      get :edit, :id => resource.to_param
    end

    it { response.should render_template :edit }
    it { assigns[assigns_model_name].should == resource }
  end
end