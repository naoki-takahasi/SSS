class Shop::BreweriesController < ApplicationController
  def index
    @users = Brewery.all
  end

  def show
    @user = Brewery.find(params[:id])
    @sakes = @user.sakes.all
  end
end