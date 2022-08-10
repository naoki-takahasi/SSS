class Shop::SakesController < ApplicationController
  def index
    @sakes = Sake.all
  end

  def show
    @sake = Sake.find(params[:id])
  end
end
