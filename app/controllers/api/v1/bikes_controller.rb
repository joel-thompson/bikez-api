class Api::V1::BikesController < AuthenticatedApplicationController

  def index
    render json: @current_user.bikes, status: 200
  end

  def create
    
  end

  def show
    
  end

  def destroy
    
  end

  def update
    
  end
end
