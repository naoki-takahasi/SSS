class Shop::BreweriesController < ApplicationController
  def index
    if params[:search] == nil
      @users = Brewery.all
    else
      @users = Brewery.where("name LIKE ? ",'%' + params[:search] + '%')
    end
  end

  def show
    @user = Brewery.find(params[:id])
    @sakes = @user.sakes
  end
end