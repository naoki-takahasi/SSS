class Brewery::BreweriesController < ApplicationController
  before_action :authenticate_brewery!
  before_action :correct_user, only: [:show, :edit, :update, :close, :withdraw]
  def show
    @user = Brewery.find(params[:id]) #該当する酒造
    @sakes = @user.sakes.page(params[:page]) #ログインしている酒造の商品一覧
  end

  def edit
    @user = Brewery.find(params[:id]) #該当する酒造
  end

  def update
    @user = Brewery.find(params[:id]) #該当する酒造
    if @user.update(breweries_params)
      flash.now[:notice] = "会員情報の変更が完了しました。"
      @sakes = @user.sakes.page(params[:page]) #ログインしている酒造の商品一覧
      render :show
    else
      render :edit
    end
  end

  def close #酒造の会員休止確認
    @user = Brewery.find(params[:id]) #該当する酒造
  end

  def withdraw #酒造の会員休止処理
    @user = Brewery.find(params[:id]) #該当する酒造
    @user.update(is_enable: false)
    sign_out @user
    redirect_to root_path, notice: "会員情報の変更が完了いたしました。"
  end

  private

  def breweries_params
    params.require(:brewery).permit(:name, :image, :post, :address, :tel)
  end

  def correct_user
    @user = Brewery.find(params[:id]) #該当する酒造
    unless @user == current_brewery #ログインしている酒造と異なった場合
      redirect_to brewery_my_page_path(current_brewery), notice: "違う会員の編集画面です。"
    end
  end
end
