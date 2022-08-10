# frozen_string_literal: true

class Brewery::SessionsController < Devise::SessionsController
  before_action :brewery_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def brewery_state
    @user = Brewery.find_by(email: params[:brewery][:email])
    return if !@user
      unless @user.valid_password?(params[:brewery][:password]) then
        redirect_to(new_brewery_session_path)
      else if @user.is_enable == false
        redirect_to(new_brewery_session_path)
           end
      end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
