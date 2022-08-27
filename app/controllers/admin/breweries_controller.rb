class Admin::BreweriesController < ApplicationController
  before_action :authenticate_admin!
  def index
    if params[:search] == nil #検索欄未入力
      @users = Brewery.page(params[:page]) #酒造全表示
    else
      @users = Brewery.where("name LIKE ? ",'%' + params[:search] + '%').page(params[:page])
      #部分一致検索
    end
  end

  def show
    @user = Brewery.find(params[:id]) #該当する酒造
    @sakes = @user.sakes.page(params[:page]) #酒造の商品一覧
  end

  def edit
    @user = Brewery.find(params[:id]) #該当する酒造
  end

  def update
    @user = Brewery.find(params[:id]) #該当する酒造
    if @user.update(breweries_params)
      flash.now[:notice] = "会員情報の変更が完了しました。"
      @sakes = @user.sakes.page(params[:page]) #該当した酒造の商品一覧
      render :show
    else
      render :edit
    end
  end

  def destroy
    @user = Brewery.find(params[:id]) #該当する酒造
    if @user.is_enable == false #酒造が退会していた場合
      @user.destroy
      flash[:notice] = "会員の削除が完了しました。"
      @users = Brewery.page(params[:page]) #酒造全表示
      render :index
    else
      flash[:notice] = "この酒造は営業しております。"
      render :edit
    end
  end


  private

  def breweries_params
    params.require(:brewery).permit(:name, :image, :post, :address, :tel, :is_enable)
  end
end
