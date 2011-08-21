class IncidentsController < ApplicationController
  inherit_resources
  before_filter :find_incident_group, :only => [:find, :index]
  before_filter :find_incidents, :flatten_incidents, :only => :find
  belongs_to :incident_group

  def find
    render :json => {:aaData => @incidents, :iTotalRecords => @count, :iTotalDisplayRecords => @count}
  end


  def find_incidents
    @length = (params["iDisplayLength"] || 25).to_i
    @start = (params["iDisplayStart"] || 0).to_i
    @count = @incident_group.incidents.count
    @length = @count if @length == -1
    @incidents = Incident.page(page).per(@length).where(:incident_group_id => params[:incident_group_id]).order_by([data_table_col_to_field(params["iSortCol_0"].to_i), params["sSortDir_0"].to_s])
  end

  def flatten_incidents
    @incidents = @incidents.map {|incident| [incident._id.to_s, incident.message.to_s, incident.occurred_at]}
  end

  def find_incident_group
    @incident_group = IncidentGroup.find(params[:incident_group_id])
  end

  def page
    (@start / @length) + 1
  end

  @@find_data_table_cols = [:_id, :message]

  def data_table_col_to_field(idx)
    @@find_data_table_cols[idx]
  end
end