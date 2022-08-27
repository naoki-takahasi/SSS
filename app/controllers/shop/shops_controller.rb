class Shop::ShopsController < ApplicationController
  before_action :authenticate_shop!
  before_action :correct_user, only: [:edit, :update, :close, :withdraw]
  def show
    @user = Shop.find(params[:id]) #該当する店舗
    if current_shop.name != "閲覧者"
      if @user != current_shop
        redirect_to shop_my_page_path(current_shop), notice: "アクセスできません。"
      end
    else
      if @user.name == "閲覧者"
        redirect_to shop_sakes_path, notice: "閲覧者はアクセスができません。"
      end
    end
    #取扱品一覧
    favorites = Favorite.where(shop_id: @user.id) #店舗の取扱品を検索
    sakes = favorites.pluck(:sake_id) #取扱品から日本酒の情報を抽出
    @sakes = Sake.where(id: sakes).page(params[:page]) #日本酒の検索
    #フォロワー一覧
    followers = Relationship.where(shop_id: @user.id) #フォロワーを検索
    breweries = followers.pluck(:brewery_id) #フォロワーから酒造を抽出
    @breweries = Brewery.where(id: breweries).page(params[:page]) #酒造を検索
  end

  def edit
    @user = Shop.find(params[:id]) #該当する店舗
  end

  def update
    @user = Shop.find(params[:id]) #該当する店舗
    if @user.update(shops_params)
      flash.now[:notice] = "会員情報の変更が完了しました。"
      #取扱品一覧
      favorites = Favorite.where(shop_id: @user.id) #店舗の取扱品を検索
      sakes = favorites.pluck(:sake_id) #取扱品から日本酒の情報を抽出
      @sakes = Sake.where(id: sakes).page(params[:page]) #日本酒の検索
      #フォロワー一覧
      followers = Relationship.where(shop_id: @user.id) #フォロワーを検索
      breweries = followers.pluck(:brewery_id) #フォロワーから酒造を抽出
      @breweries = Brewery.where(id: breweries).page(params[:page]) #酒造を検索
      render :show
    else
      render :edit
    end
  end

  def close #店舗の会員休止確認
    @user = Shop.find(params[:id]) #該当する店舗
  end

  def withdraw #店舗の会員休止処理
    @user = Shop.find(params[:id]) #該当する店舗
    @user.update(is_enable: false)
    sign_out @user
    redirect_to root_path, notice: "会員情報の変更が完了いたしました。"
  end

  private

  def shops_params
    params.require(:shop).permit(:name, :image, :post, :address, :tel)
  end

  def correct_user
    @user = Shop.find(params[:id]) #該当する店舗
    if current_shop.name == "閲覧者"
      redirect_to shop_sakes_path, notice: "閲覧者はアクセスできません。"
    else
      if @user != current_shop
        redirect_to shop_my_page_path(current_shop), notice: "違う会員の編集画面です。"
      end
    end
  end
end
