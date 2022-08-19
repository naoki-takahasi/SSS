class Shop::FavoritesController < ApplicationController
  def create
    sake = Sake.find(params[:sake_id])
    @favorite = sake.favorites.new(shop_id: current_shop.id)
    @favorite.save
    render 'create'
  end

  def destroy
    sake = Sake.find(params[:sake_id])
    @favorite = sake.favorites.find_by(shop_id: current_shop.id)
    @favorite.destroy
    render 'destroy'
  end
end
