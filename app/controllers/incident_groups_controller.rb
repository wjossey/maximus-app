class IncidentGroupsController < ApplicationController
  inherit_resources
  before_filter :authenticate_user!
  before_filter :find_incident_groups, :flatten_incident_groups, :only => :find

  def find
    render :json => {:aaData => @incident_groups, :iTotalRecords => @count, :iTotalDisplayRecords => @count}
  end

  def show
    Rails.logger.info "IN the show method, redirecting now..."
    redirect_to user_project_incident_group_incidents_url(current_user, :project_id => params[:project_id], :incident_group_id => params[:id])
  end


  def find_incident_groups
    @length = (params["iDisplayLength"] || 25).to_i
    @start = (params["iDisplayStart"] || 0).to_i
    @count = IncidentGroup.count
    @length = @count if @length == -1
    @incident_groups = IncidentGroup.page(page).per(@length).order_by([data_table_col_to_field(params["iSortCol_0"].to_i), params["sSortDir_0"].to_s])
  end

  def flatten_incident_groups
    @incident_groups = @incident_groups.map {|incident_group| ["<a href='#{user_project_incident_group_incidents_url(:user_id => params[:user_id], :project_id => params[:project_id], :incident_group_id => incident_group.id)}'>#{incident_group._id.to_s}</a>", incident_group.group_title.to_s, incident_group.first_occurrence, incident_group.incident_count]}
  end

  def page
    (@start / @length) + 1
  end

  @@find_data_table_cols = [:_id, :group_title, :first_occurrence, :count]

  def data_table_col_to_field(idx)
    @@find_data_table_cols[idx]
  end

end
