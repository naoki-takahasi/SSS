class Brewery::SakesController < ApplicationController
  before_action :authenticate_brewery!
  before_action :correct_user, only: [:show, :edit, :update]
  def index
    @user = current_brewery
    if params[:search] == nil #検索欄未入力
      if params[:search_tag_id] == nil #絞り込み未入力(初期状態)
        @sakes = @user.sakes.page(params[:page]) #自社製品全表示
      else
        @sakes = Tag.find(params[:tag_id]).sakes.where(brewery_id: @user).page(params[:page]) #絞り込み結果
      end
    elsif params[:search_tag_id] == ""
      #検索欄のみ入力時
      @sakes = Sake.where("name LIKE ? ",'%' + params[:search] + '%').where(brewery_id: @user).page(params[:page]) #部分検索結果
    else
      #全て入力時
      @search_tag_id = params[:search_tag_id] #絞り込み結果
      @sakes = Sake.where("name LIKE ? ",'%' + params[:search] + '%').where(tag_id: @search_tag_id).where(brewery_id: @user).page(params[:page])
      #+部分検索結果
    end
  end

  def new
    @sake = Sake.new
  end

  def create
    @sake = Sake.new(sake_params)
    @sake.brewery_id = current_brewery.id
    if @sake.save
      flash[:notice] = "お酒の登録が完了しました。"
      redirect_to brewery_sake_path(@sake.id)
    else
      render :new
    end
  end

  def show
    @sake = Sake.find(params[:id]) #該当する日本酒
    #取扱店一覧
    favorites = Favorite.where(sake_id: @sake.id) #日本酒から取扱店情報を検索
    favorite_shops = favorites.pluck(:shop_id) #取扱店情報から店舗を抽出
    @favorite_shops = Shop.where(id: favorite_shops).page(params[:page]) #店舗を検索
    #コメント一覧
    @comments = Comment.where(sake_id: @sake.id).page(params[:page]) #該当する日本酒のコメントを検索
  end

  def edit
    @sake = Sake.find(params[:id]) #該当する日本酒
  end

  def update
    @sake = Sake.find(params[:id]) #該当する日本酒
    if @sake.update(sake_params)
      redirect_to brewery_sake_path(@sake.id), notice: "お酒の情報を変更しました。"
    else
      render :edit
    end
  end

  private
  def sake_params
    params.require(:sake).permit(:name, :price, :explain, :image, :is_active, :tag_id)
  end

  def correct_user
    @sake = Sake.find(params[:id]) #該当する日本酒
    unless @sake.brewery_id == current_brewery.id #ログインしている酒造と異なった場合
      redirect_to brewery_sakes_path, notice: "自社のお酒以外は編集できません。"
    end
  end
end
