class Brewery::ShopsController < ApplicationController
  def index
    if params[:search] == nil
      @users = Shop.page(params[:page])
    else
      @users = Shop.where("name LIKE ? ",'%' + params[:search] + '%')
    end
  end

  def show
    @user = Shop.find(params[:id])
    favorites = Favorite.where(shop_id: @user)
    sakes = favorites.pluck(:sake_id)
    @sakes = Sake.find(sakes).find(brewery_id: current_brewery.id).page(params[:page])
  end
end
