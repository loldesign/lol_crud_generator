class <%=@settings[:controller]%>Controller < ApplicationController
  before_filter :load_<%= @settings[:assigns] %>

  def new
  end

  def create
    if @<%= @settings[:assigns] %>.save
      redirect_to <%= @settings[:path_prefix] %><%= @settings[:assigns_plural] %>_path(), notice: "#{<%= @settings[:model] %>.model_name.human} criado com sucesso."
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    if @<%= @settings[:assigns] %>.update_attributes(params[:<%= @settings[:assigns] %>])
      redirect_to <%= @settings[:path_prefix] %><%= @settings[:assigns_plural] %>_path(), notice: "#{<%= @settings[:model] %>.model_name.human} editado com sucesso."
    else
      render action: :edit
    end
  end

  def show
  end

  private
  def load_<%= @settings[:assigns] %>
    @<%= @settings[:assigns] %> = <%= @settings[:model] %>.last || <%= @settings[:model] %>.new(params[:<%= @settings[:assigns] %>])
  end
end
