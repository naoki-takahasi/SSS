# frozen_string_literal: true

class Shop::SessionsController < Devise::SessionsController
  before_action :shop_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  def guest_sign_in
    shop = Shop.guest
    sign_in shop
    redirect_to shop_sakes_path, notice: '閲覧者としてログインしました。'
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
    @user = Shop.find_by(email: params[:shop][:email]) #emailから会員情報を検索
    if !@user #会員情報なしの場合
      redirect_to new_shop_session_path, notice: "Emailかパスワードが間違っております。"
    elsif !@user.valid_password?(params[:shop][:password]) #パスワード不一致の場合
      redirect_to new_shop_session_path, notice: "Emailかパスワードが間違っております。"
    else #会員情報あり、パスワード一致
      if @user.is_enable == false #退会している会員の場合
        redirect_to new_shop_session_path, notice: "この会員は退会しております。"
      end
    end
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
