#encoding: utf-8
shared_examples 'CRUD DELETE destroy' do |options|
  before do
    @model_name                     = options[:resource].classify
    @model_klass                    = @model_name.constantize
    @model_name_pluralized          = @model_name.humanize.pluralize.downcase
    @assigns_model_name             = @model_name.underscore.to_sym
    @pluralized_assigns_model_name  = @model_name.underscore.pluralize.to_sym
    @need_redirect_to               = send(options[:redirect_to] || "#{@pluralized_assigns_model_name}_path")
  end

  describe "DELETE destroy" do
    let(:resource_attrs) do
      hash = {id: 1}
      hash[options[:parent_attr_name] || :user_id] = current_user.id if options[:has_parent]
      hash
    end

    let(:resource)  { mock_model(@model_klass, resource_attrs) }

    before do 
      @model_klass.stub(:find).and_return(resource)
      resource.stub(:destroy).and_return(true)
    end

    it "destroys the requested resource" do
      resource.should_receive(:destroy).and_return(true)
      delete :destroy, {:id => resource.to_param}
    end

    it "redirects to the resource list" do
      delete :destroy, {:id => resource.to_param}
      response.should redirect_to(@need_redirect_to)
    end

    it "should have a message" do
      delete :destroy, {:id => resource.to_param}
      flash[:notice].should =~ /removido com sucesso./ 
    end

    it "should not have an unauthorized message" do 
      delete :destroy, {id: resource.to_param}
      flash[:alert].should_not =~ /Você não tem permissão para visualizar a área desejada./
    end
  end
end