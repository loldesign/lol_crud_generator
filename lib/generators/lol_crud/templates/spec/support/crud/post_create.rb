#encoding: utf-8
shared_examples 'CRUD POST create' do |options|
  let!(:model_name)                   { options[:resource].classify            }
  let!(:model_klass)                  { model_name.constantize                 }
  let!(:model_name_pluralized)        { model_name.humanize.pluralize          }
  let!(:assigns_model_name)           { model_name.underscore.to_sym           }
  let!(:pluralized_assigns_model_name){ model_name.underscore.pluralize.to_sym }
  let!(:need_redirect_to)             { send(options[:redirect_to] || "#{assigns_model_name}_path", options[:hasnt_resources_list] ? nil : resource) }
  let!(:resource)                     { options[:resource_is_current_user] ? current_user : mock_model(model_klass) }

  
  describe "POST create" do
    let(:resource_attrs) do
      hash = {}
      hash[options[:parent_attr_name] || :user_id] = current_user.id if options[:has_parent]
      hash
    end

    let(:resource)  { mock_model(model_klass, resource_attrs) }
 
    def do_post
      post :create, assigns_model_name => resource_attrs
    end

    context "with valid mocked data" do
      before do
        model_klass.should_receive(:new).and_return(resource)
        resource.stub(:'user_id=').and_return(current_user.id) if options[:has_parent]
        resource.stub(:save).and_return(true)
        
        do_post
      end

      it{ response.should redirect_to(need_redirect_to) }
      it{ flash[:notice].should =~ /criado com sucesso./ }
    end

    context "with valid persisted data" do
      it{ expect{ post :create, assigns_model_name => attributes_for(options[:resource]) }.to change(model_klass, :count).by(1) }
    end

    context "with invalid data" do
      before do
        model_klass.should_receive(:new).and_return(resource)
        resource.stub(:save).and_return(false)
        resource.stub(:'user_id=').and_return(current_user.id) if options[:has_parent]

        do_post
      end

      it { assigns[assigns_model_name].should  eq(resource) }
      it { flash[:notice].should_not =~ /criado com sucesso./ }
    end
  end
end