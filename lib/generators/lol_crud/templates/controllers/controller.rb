class <%=@settings[:controller]%>Controller < ApplicationController
  before_filter :load_<%= @settings[:assigns] %>         , only: [:edit, :update, :show, :destroy]
  before_filter :new_instance_<%= @settings[:assigns] %> , only: [:new, :create]

  def index
    @<%= @settings[:plural] %>= <%=@settings[:model]%>.all
  end

  def new
  end

  def create
    if @<%= @settings[:assigns] %>.save
      redirect_to <%= @settings[:path_prefix] %><%= @settings[:assigns] %>_path(@<%= @settings[:assigns] %>), notice: "#{<%= @settings[:model] %>.model_name.human} criado com sucesso"
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    if @<%= @settings[:assigns] %>.update_attributes(params[:<%= @settings[:assigns] %>])
      redirect_to <%= @settings[:path_prefix] %><%= @settings[:assigns] %>_path(@<%= @settings[:assigns] %>), notice: "#{<%= @settings[:model] %>.model_name.human} editado com sucesso."
    else
      render action: :edit
    end
  end

  def show
  end

  def destroy
    @<%= @settings[:assigns] %>.destroy
    redirect_to <%= @settings[:path_prefix] %><%= @settings[:assigns_plural] %>_path, notice: "#{<%= @settings[:model] %>.model_name.human} removido com sucesso."
  end

  private
  def load_<%= @settings[:assigns] %>
    @<%= @settings[:assigns] %> = <%= @settings[:model] %>.find(params[:id])
  end

  def new_instance_<%= @settings[:assigns] %>
    @<%= @settings[:assigns] %> = <%= @settings[:model] %>.new(params[:<%= @settings[:assigns] %>])
  end
end
