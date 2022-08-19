# frozen_string_literal: true

class Shop::SessionsController < Devise::SessionsController
  before_action :shop_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  def guest_sign_in
    shop = Shop.guest
    sign_in shop
    redirect_to shop_my_page_path(shop), notice: '閲覧者としてログインしました。'
  end

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

  def shop_state
    @user = Shop.find_by(email: params[:shop][:email])
    return if !@user
      unless @user.valid_password?(params[:shop][:password]) then
        redirect_to(new_shop_session_path)
      else if @user.is_enable == false
        redirect_to(new_shop_session_path)
           end
      end
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
