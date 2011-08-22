class UsersController < ApplicationController
  inherit_resources
  before_filter :authenticate_user!

  def index
    redirect_to(user_projects_url(current_user))
  end

  def show

  end
end