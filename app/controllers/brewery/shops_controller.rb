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
    sake_ids = favorites.pluck(:sake_id)
    @sakes = Sake.where(id: sake_ids, brewery_id: current_brewery.id).page(params[:page])
  end
end
