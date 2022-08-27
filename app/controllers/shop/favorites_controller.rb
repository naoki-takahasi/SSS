class Shop::FavoritesController < ApplicationController
  before_action :authenticate_shop!
  def create
    sake = Sake.find(params[:sake_id]) #該当する日本酒を検索
    @favorite = sake.favorites.new(shop_id: current_shop.id)
    @favorite.save
    render 'create'
  end

  def destroy
    sake = Sake.find(params[:sake_id]) #該当する日本酒を検索
    @favorite = sake.favorites.find_by(shop_id: current_shop.id)
    @favorite.destroy
    render 'destroy'
  end
end
