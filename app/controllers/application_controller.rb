class ApplicationController < ActionController::API
  include ActionController::Cookies

  before_action :authorize
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_record


  private 

  def render_invalid_record(e)
    render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
  end

  def authorize 
    @current_user = User.find_by_id(session[:user_id])
    render json: { errors: ["Not authorized"] }, status: :unauthorized unless @current_user
  end
end
