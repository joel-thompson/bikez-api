class Api::V1::BikesController < AuthenticatedApplicationController
  def index
    render json: @current_user.bikes, status: 200
  end

  def show
    bike = @current_user.bikes.find_by(id: params[:id])

    if bike
      render json: bike, status: 200
    else
      render json: { errors: ["bike not found"] }, status: 404
    end
  end

  def create
    bike = Bike.create(
      user: @current_user,
      name: params[:name],
    )

    if bike.persisted?
      render json: bike, status: 200
    else
      render json: { errors: bike.errors.full_messages }, status: 400
    end
  end

  def update
    bike = @current_user.bikes.find_by(id: params[:id])

    if bike
      if bike.update(name: params[:name])
        render json: bike, status: 200 
      else
        render json: { errors: bike.errors.full_messages }, status: 400
      end
    else
      render json: { errors: ["bike not found"] }, status: 404
    end
  end

  def destroy
    bike = @current_user.bikes.find_by(id: params[:id])

    if bike
      bike.destroy!
    else
      render json: { errors: ["bike not found"] }, status: 404
    end
  end

end
