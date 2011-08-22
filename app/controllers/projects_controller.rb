class ProjectsController < ApplicationController
  inherit_resources
  before_filter :authenticate_user!

  def show
    Rails.logger.info "In the show action in the projects controller"
    redirect_to user_project_incident_groups_url(:user_id => params[:user_id], :project_id => params[:id])
  end

end
