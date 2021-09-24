class CommentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    # added rescue_from
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
      if params[:pet_id]
        pet = Pet.find(params[:pet_id])
        comments = pet.comments
      else
        comments = Comment.all
      end
      render json: comments, include: :pet
    end
  
    def show
      comment = Comment.find(params[:id])
      render json: comment, include: :pet
    end
  
    def create
      comment = Comment.create!(comment_params)
      render json: comment, status: :created
    end
  
    private
  
    def render_not_found_response
      render json: { errors: ["Comment not found"] }, status: :not_found
    end
  
    def comment_params
      params.permit(:content, :user_id, :pet_id)
    end

    def render_unprocessable_entity_response(invalid)
      render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
  
end
