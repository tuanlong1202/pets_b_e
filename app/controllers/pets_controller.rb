class PetsController < ApplicationController

    before_action :authorize
    skip_before_action :authorize, only: [:index]

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    # added rescue_from
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    # GET /pets
    def index
      pets = Pet.all
      render json: pets
    end
  
    # POST /pets
    def create
      pet = Pet.create!(pet_params)
      render json: pet, status: :created
    end
  
    # GET /pets/:id
    def show
      pet = find_pet
      render json: pet, include: :comments
    end
  
    # PATCH /pets/:id
    def update
      pet = find_pet
      pet.update!(pet_params)
      render json: pet
    end
  
    # DELETE /pets/:id
    def destroy
      pet = find_pet
      pet.destroy
      head :no_content
    end
  
    private
  
    def find_pet
      Pet.find(params[:id])
    end
  
    def pet_params
      params.permit(:name, :image, :user_id)
    end
  
    def render_not_found_response
      render json: { errors: ["Pet not found"] }, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
      render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def authorize
      return render json: { errors: ["Not authorized"] }, status: :unauthorized unless session.include? :user_id
    end
    
end
