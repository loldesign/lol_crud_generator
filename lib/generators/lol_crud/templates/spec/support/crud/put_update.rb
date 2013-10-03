#encoding: utf-8
shared_examples 'CRUD PUT update' do |options|
  let!(:model_name)                   { options[:resource].classify            }
  let!(:model_klass)                  { model_name.constantize                 }
  let!(:model_name_pluralized)        { model_name.humanize.pluralize          }
  let!(:assigns_model_name)           { model_name.underscore.to_sym           }
  let!(:pluralized_assigns_model_name){ model_name.underscore.pluralize.to_sym }
  let!(:need_redirect_to)             { send(options[:redirect_to] || "#{assigns_model_name}_path", options[:hasnt_resources_list] ? nil : resource) }
  let!(:resource)                     { options[:resource_is_current_user] ? current_user : mock_model(model_klass) }

  before{ resource.stub(options[:parent_attr_name] || :user_id).and_return(current_user.id) if options[:has_parent] }

  describe "UPDATE" do
    before{ model_klass.stub(:find).and_return(resource) }

    context 'valid' do
      before do
        resource.stub(:update_attributes).and_return(true)
        model_klass.any_instance.stub(:update_attributes).and_return(true)
      end

      it "should update valid" do
        put :update, assigns_model_name => attributes_for(assigns_model_name), id: resource.to_param
        response.should redirect_to(need_redirect_to)
      end
    end
    context 'invalid' do
      before do
        resource.stub(:update_attributes).and_return(false)
        model_klass.any_instance.stub(:update_attributes).and_return(false)
      end

      it "should not update" do
        put :update, assigns_model_name => attributes_for(assigns_model_name), id: resource.to_param
        response.should render_template('edit')
      end
    end
  end
end