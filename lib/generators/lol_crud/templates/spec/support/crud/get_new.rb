#encoding: utf-8
shared_examples 'CRUD GET new' do |options|
  before do
    @model_name                     = options[:resource].classify
    @model_klass                    = @model_name.constantize
    @model_name_pluralized          = @model_name.humanize.pluralize.downcase
    @assigns_model_name             = @model_name.underscore.to_sym
    @pluralized_assigns_model_name  = @model_name.underscore.pluralize.to_sym
  end

  describe "#new" do
    let(:resource_attrs) do
      hash = {}
      hash[options[:parent_attr_name] || :user_id] = current_user.id if options[:has_parent]
      hash
    end

    let!(:resource)  { build(@model_klass, resource_attrs) }

    before do
      @model_klass.stub(:new).and_return(resource)
      get :new
    end

    it { response.should_not redirect_to root_path }
    it { response.should render_template :new }
    it { assigns[@assigns_model_name].should == resource }
  end
end