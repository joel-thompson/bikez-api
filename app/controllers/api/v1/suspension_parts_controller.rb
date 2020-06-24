class Api::V1::SuspensionPartsController < AuthenticatedApplicationController
  def index
    if params[:ids]
      suspension_parts = @current_user.suspension_parts.find(params[:ids])
      render json: suspension_parts, status: 200
    else
      render json: @current_user.suspension_parts, status: 200
    end
  end

  def show
    suspension_part = @current_user.suspension_parts.find_by(id: params[:id])

    if suspension_part
      render json: suspension_part, status: 200
    else
      render json: { errors: ["suspension part not found"] }, status: 404
    end
  end

  def create
    part = SuspensionPart.create(suspension_part_params.merge(user: @current_user))

    if part.persisted?
      render json: part, status: 200
    else
      render json: { errors: part.errors.full_messages }, status: 400
    end
  end

  def update
    part = @current_user.suspension_parts.find_by(id: params[:id])

    if part
      if part.update(suspension_part_params)
        render json: part, status: 200 
      else
        render json: { errors: part.errors.full_messages }, status: 400
      end
    else
      render json: { errors: ["suspension part not found"] }, status: 404
    end
  end

  def destroy
    part = @current_user.suspension_parts.find_by(id: params[:id])

    if part
      part.destroy!
    else
      render json: { errors: ["suspension part not found"] }, status: 404
    end
  end

  private def suspension_part_params
    params.permit(
      :name,
      :component_type,
      :high_speed_compression,
      :low_speed_compression,
      :high_speed_rebound,
      :low_speed_rebound,
      :volume,
      :pressure,
      :spring_rate,
    ).to_h.compact.symbolize_keys
  end

end
