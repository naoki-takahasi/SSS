class Shop::BreweriesController < ApplicationController
  before_action :authenticate_shop!
  def index
    if params[:search] == nil #検索欄未入力
      @users = Brewery.page(params[:page]) #酒造全表示
    else
      @users = Brewery.where("name LIKE ? ",'%' + params[:search] + '%').page(params[:page])
      #部分一致検索
    end

  end

  def show
    @user = Brewery.find(params[:id]) #該当する酒造
    @sakes = @user.sakes.where(is_active: true).page(params[:page]) #酒造の商品一覧
  end
end