class IncidentsController < ApplicationController
  inherit_resources
  before_filter :find_incidents, :flatten_incidents, :except => :index

  def index
    @incidents = Incident.page(1).per(25)
  end

  def find
    render :json => {:aaData => @incidents, :iTotalRecords => @count, :iTotalDisplayRecords => @count}
  end


  def find_incidents
    Rails.logger.info "Direction: #{params["sSortDir_0"].to_s}"
    @length = (params["iDisplayLength"] || 25).to_i
    @start = (params["iDisplayStart"] || 0).to_i
    @incidents = Incident.page(page).per(@length).order_by([:_id, params["sSortDir_0"].to_s])
    @count = Incident.count
  end

  def flatten_incidents
    @incidents = @incidents.map {|incident| [incident._id.to_s, incident.message.to_s]}
  end

  def page
    (@start / @length) + 1
  end

end