class Api::V1::PostsController < ApplicationController
  include CurrentUserConcern

  def index
    if @current_user
      render json: @current_user.posts.to_a.to_json, status: :ok
    else
      render json: { posts: [] }, status: 403
    end
  end
end
