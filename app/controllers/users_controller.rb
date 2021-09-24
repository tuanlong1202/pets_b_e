class UsersController < ApplicationController

    before_action :authorize
    skip_before_action :authorize, only: [:create, :show]    

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    # added rescue_from
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    # GET /users
    def index
      users = User.all
      render json: users
    end

    def create
      user = User.create!(user_params)
      if user.valid?
        session[:user_id] = user.id
        render json: user, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
    
    def show
        user = User.find_by(id: session[:user_id])
        if user
          render json: user
        else
          render json: { errors: ["Not authorized"] }, status: :unauthorized
        end
    end

    # POST /users
#    def create
#      user = User.create!(user_params)
#      render json: user, status: :created
#    end
  
    # GET /user/:id
#    def show
#      user = find_user
#      render json: user, include: :pets
#    end
  
    # PATCH /user/:id
    def update
      user = find_user
      user.update!(user_params)
      render json: user
    end
  
    # DELETE /user/:id
    def destroy
      user = find_user
      user.destroy
      head :no_content
    end
  
    private
  
    def find_user
      User.find(params[:id])
    end
  
    def user_params
      params.permit(:user_name, :email, :password, :password_confirmation)
    end
  
    def render_not_found_response
      render json: { errors: ["User not found"] }, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
      render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def authorize
      return render json: { errors: ["Not authorized"] }, status: :unauthorized unless session.include? :user_id
    end

end
