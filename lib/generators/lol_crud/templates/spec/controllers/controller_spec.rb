require 'spec_helper'

describe <%=@settings[:controller]%>Controller do
  <% if @settings[:need_login] %>
  <%= "let(:current_user){ FactoryGirl.create(:admin) }"  %>
  <%= "before{ sign_in current_user }"%>
  <% end %>
  it_should_behave_like "CRUD GET index"      , resource: '<%=@settings[:assigns]%>'
  it_should_behave_like "CRUD GET show"       , resource: '<%=@settings[:assigns]%>'
  it_should_behave_like "CRUD GET new"        , resource: '<%=@settings[:assigns]%>' 
  it_should_behave_like "CRUD GET edit"       , resource: '<%=@settings[:assigns]%>' 
  it_should_behave_like "CRUD POST create"    , resource: '<%=@settings[:assigns]%>', redirect_to: "<%= @settings[:path_prefix] %><%= @settings[:assigns] %>_path"
  it_should_behave_like "CRUD PUT update"     , resource: '<%=@settings[:assigns]%>', redirect_to: "<%= @settings[:path_prefix] %><%= @settings[:assigns] %>_path"
  it_should_behave_like "CRUD DELETE destroy" , resource: '<%=@settings[:assigns]%>', redirect_to: "<%= @settings[:path_prefix] %><%= @settings[:plural] %>_path"

end
