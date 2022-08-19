class Admin::ShopsController < ApplicationController
  def index
    @users = Shop.all
  end

  def show
    @user = Shop.find(params[:id])
    @favorites = Favorite.where(shop_id: @user.id)
  end

  def edit
    @user = Shop.find(params[:id])
  end

  def update
    @user = Shop.find(params[:id])
    if @user.update(shops_params)
      flash.now[:notice] = '会員情報の変更が完了しました。'
      render :show
    else
      render :edit
    end
  end

  def destroy
    @user = Shop.find(params[:id])
    if @user.is_enable == false
      @user.destroy
      flash[:notice] = "会員の削除が完了しました"
      @users = Shop.all
      render :index
    else
      flash[:notice] = "この店舗は営業しております"
      render :edit
    end
  end


  private

  def shops_params
    params.require(:shop).permit(:name, :image, :post, :address, :tel)
  end
end
