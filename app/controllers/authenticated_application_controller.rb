class AuthenticatedApplicationController < ApplicationController
  include CurrentUserConcern
  before_action :logged_in_user

  private def logged_in_user
    unless @current_user
      render json: { errors: ["must be logged in"] }, status: 403
    end
  end
end