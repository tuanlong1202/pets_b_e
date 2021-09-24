class RatingsController < ApplicationController

    before_action :authorize
    skip_before_action :authorize, only: [:index]

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    # added rescue_from
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
      if params[:pet_id]
        pet = Pet.find(params[:pet_id])
        ratings = pet.ratings
      else
        ratings = Rating.all
      end
      render json: ratings, include: :pet
    end
  
    def show
      rating = Rating.find(params[:id])
      render json: rating, include: :pet
    end
  
    def create
      rating = Rating.create!(rating_params)
      render json: rating, status: :created
    end
  
    private
  
    def render_not_found_response
      render json: { errors: ["Rating not found"] }, status: :not_found
    end
  
    def rating_params
      params.permit(:point, :user_id, :pet_id)
    end

    def render_unprocessable_entity_response(invalid)
      render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def authorize
      return render json: { errors: ["Not authorized"] }, status: :unauthorized unless session.include? :user_id
    end
  
end
