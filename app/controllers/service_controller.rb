class ServiceController < ApplicationController
  
  def verify_user
    user = User.find_by(email: user_params[:email])
    if user.authorized_with_image?(user_params[:image])
      render json: format_msg("OK"), status: user.status
    else
      render json: format_msg("No Autorizado"), status: user.status
    end
  end

  private
  def format_msg(msg)
    { message: msg }
  end

  def user_params
    params.require(:image)
    params.require(:email)
    params.permit(:image, :email)
  end
end