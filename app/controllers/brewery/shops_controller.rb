class Brewery::ShopsController < ApplicationController
  before_action :authenticate_brewery!
  def index
    if params[:search] == nil #検索欄未入力
      @users = Shop.where(id: 2..Float::INFINITY).page(params[:page]) #ゲスト以外を全表示
    else
      @users = Shop.where("name LIKE ? ",'%' + params[:search] + '%').page(params[:page]) #部分一致検索
    end
  end

  def show
    @user = Shop.find(params[:id]) #該当する店舗
    favorites = Favorite.where(shop_id: @user) #店舗の取扱品を検索
    sake_ids = favorites.pluck(:sake_id) #取扱品から日本酒の情報を抽出
    @sakes = Sake.where(id: sake_ids, brewery_id: current_brewery.id).page(params[:page]) #取り扱ってる自社製品の検索
  end
end
