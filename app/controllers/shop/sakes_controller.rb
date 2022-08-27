class Shop::SakesController < ApplicationController
  before_action :authenticate_shop!
  def index
    if params[:search] == nil #検索欄未入力
      if params[:search_tag_id] == nil #絞り込み未入力(初期状態)
        @sakes = Sake.where(is_active: true).page(params[:page]) #販売中全表示
      else
        @sakes = Tag.find(params[:tag_id]).sakes.where(is_active: true).page(params[:page]) #絞り込み結果
      end
    elsif params[:search_tag_id] == ""
      #検索欄のみ入力時
      @sakes = Sake.where("name LIKE ? ",'%' + params[:search] + '%').where(is_active: true).page(params[:page]) #部分検索結果
    else
      #全て入力時
      @search_tag_id = params[:search_tag_id] #絞り込み結果
      @sakes = Sake.where("name LIKE ? ",'%' + params[:search] + '%').where(tag_id: @search_tag_id).where(is_active: true).page(params[:page])
      #+部分検索結果
    end
  end

  def show
    @sake = Sake.find(params[:id]) #該当する日本酒
    if @sake.is_active == false #日本酒が休売している場合
      flash.now[:notice] = "このお酒は現在販売しておりません。"
      @sakes = Sake.where(is_active: true).page(params[:page]) #販売中全表示
      render :index
    end
    #取扱店一覧
    favorites = Favorite.where(sake_id: @sake.id) #日本酒から取扱店情報を検索
    users = favorites.pluck(:shop_id) #取扱店情報から店舗を抽出
    @users = Shop.where(id: users).page(params[:page]) #店舗を検索
    @comment = Comment.new
    @comments = @sake.comments.where(shop_id: current_shop) #店舗のコメント
  end
end
