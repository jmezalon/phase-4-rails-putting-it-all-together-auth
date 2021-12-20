class UsersController < ApplicationController
    before_action :authorize, only: :show

    def create
        user = User.create!(users_params)
        session[:user_id] = user.id
        render json: user, status: :created
    end

    def show
        user = User.find_by_id(session[:user_id])
        render json: user, status: :ok
    end

    private

    def users_params
        params.permit(:username, :password, :password_confirmation, :image_url, :bio)
    end
end
