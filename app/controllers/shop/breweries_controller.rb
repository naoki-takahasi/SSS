class Shop::BreweriesController < ApplicationController
  def index
    if params[:search] == nil
      @users = Brewery.page(params[:page])
    else
      @users = Brewery.where("name LIKE ? ",'%' + params[:search] + '%').page(params[:page])
    end
  end

  def show
    @user = Brewery.find(params[:id])
    @sakes = @user.sakes.page(params[:page])
  end
end