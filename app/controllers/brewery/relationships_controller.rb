class Brewery::RelationshipsController < ApplicationController
  before_action :authenticate_brewery!
  def followed
    #フォローした店舗一覧
    relationships = Relationship.where(brewery_id: current_brewery.id) #フォローをログインしている酒造から検索
    users = relationships.pluck(:shop_id) #フォローから店舗を抽出
    @users = Shop.where(id: users).page(params[:page]) #店舗を検索
    #取扱店一覧
    sakes = Sake.where(brewery_id: current_brewery.id) #日本酒をログインしている酒造から検索
    favorites = Favorite.where(sake_id: sakes) #日本酒から取扱店情報を検索
    shops = favorites.pluck(:shop_id) #取扱店情報から店舗を抽出
    @shops = Shop.where(id: shops).page(params[:page]) #店舗を検索

  end

  def create
    relationship = Relationship.new(brewery_id: current_brewery.id, shop_id: params[:shop_id])
    relationship.save
    redirect_to request.referer
  end

  def destroy
    relationship = Relationship.find_by(brewery_id: current_brewery.id, shop_id: params[:shop_id])
    relationship.destroy
    redirect_to request.referer
  end
end
