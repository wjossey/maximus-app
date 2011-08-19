class IncidentsController < ApplicationController
  inherit_resources

  def index
    @incidents = [Incident.all[0], Incident.all[1]]
  end

end