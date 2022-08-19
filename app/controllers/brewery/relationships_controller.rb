class Brewery::RelationshipsController < ApplicationController
  def followed
    relationships = Relationship.where(brewery_id: current_brewery.id)
    users = relationships.pluck(:shop_id)
    @users = Shop.find(users)

    sakes = Sake.where(brewery_id: current_brewery.id)
    favorites = Favorite.where(sake_id: sakes)
    shops = favorites.pluck(:shop_id)
    @shops = Shop.find(shops)
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
