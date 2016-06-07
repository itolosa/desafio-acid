class SessionController < ApplicationController
  include SessionHelper

  def index
    # solo responde con el formulario
  end

  def login
    # hace el request a webservice2
    response = post_to_webservice(login_params[:email], login_params[:image])

    # Se envian los correos de inicio de sesion
    # deliver_later es un metodo que facilita ActiveJob
    # permite encolar correos como workers
    if response.status == 200
      UserMailer.login_success_email(login_params[:email], request.user_agent).deliver_later
      render json: response.body, status: response.status
    elsif response.status == 401
      UserMailer.login_failed_email(login_params[:email], request.user_agent).deliver_later
      render json: response.body, status: response.status
    else
      # Codigo de respuesta no esperado
      UserMailer.login_failed_email(login_params[:email], request.user_agent).deliver_later
      raise "Error Interno"
    end

    #render json: response.body, status: response.status
  end

  private

  def login_params
    # fuerza el requerimiento de parametros
    params.require(:image)
    params.require(:email)

    # filtra los parametros
    params.permit(:image, :email)
  end
end
