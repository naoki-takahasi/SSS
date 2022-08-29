class Admin::ShopsController < ApplicationController
  before_action :authenticate_admin!
  def index
    if params[:search] == nil #検索欄未入力
      @users = Shop.page(params[:page]) #店舗全表示
    else
      @users = Shop.where("name LIKE ? ",'%' + params[:search] + '%').page(params[:page]) #部分検索結果
    end
  end

  def show
    @user = Shop.find(params[:id]) #該当する店舗
    favorites = Favorite.where(shop_id: @user) #店舗の取扱品を検索
    sakes = favorites.pluck(:sake_id) #取扱品から日本酒の情報を抽出
    @sakes = Sake.where(id: sakes).page(params[:page]) #取り扱ってる日本酒の検索
  end

  def edit
    @user = Shop.find(params[:id]) #該当する店舗
  end

  def update
    @user = Shop.find(params[:id]) #該当する店舗
    if @user.update(shops_params)
      redirect_to admin_shop_path(@user.id), notice: "会員情報の変更が完了しました。"
    else
      render :edit
    end
  end

  def destroy
    @user = Shop.find(params[:id]) #該当する店舗
    if @user.is_enable == false #店舗か閉店している場合
      @user.destroy
      redirect_to admin_shops_path, notice: "会員の削除が完了しました。"
    else
      flash[:notice] = "この店舗は営業しております。"
      render :edit
    end
  end


  private

  def shops_params
    params.require(:shop).permit(:name, :image, :post, :address, :tel, :is_enable)
  end
end
