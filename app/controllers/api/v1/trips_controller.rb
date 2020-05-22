class Api::V1::TripsController < ApplicationController
  def index
    trips = [
      {trip_name: "whistler", id: 1},
      {trip_name: "northstar", id: 2}
    ]
    
    render json: { results: trips }.to_json, status: :ok
  end
end