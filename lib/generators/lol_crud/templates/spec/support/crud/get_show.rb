#encoding: utf-8
shared_examples 'CRUD GET show' do |options|
  before do
    @model_name                     = options[:resource].classify
    @model_klass                    = @model_name.constantize
    @model_name_pluralized          = @model_name.humanize.pluralize
    @assigns_model_name             = @model_name.underscore.to_sym
    @pluralized_assigns_model_name  = @model_name.underscore.pluralize.to_sym
  end

  describe "#show" do
    let!(:resource){ create(options[:resource]) }

    before { get :show, id: resource.to_param }

    it{ response.should render_template :show }
    it{ assigns[@assigns_model_name].should == resource }
  end
end