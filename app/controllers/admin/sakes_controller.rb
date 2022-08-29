class Admin::SakesController < ApplicationController
  before_action :authenticate_admin!
  def index
    if params[:search] == nil #検索欄未入力
      if params[:search_tag_id] == nil #絞り込み未入力(初期状態)
        @sakes = Sake.page(params[:page]) #日本酒全表示
      else
        @sakes = Tag.find(params[:tag_id]).sakes.page(params[:page]) #絞り込み結果
      end
    elsif params[:search_tag_id] == ""
      #検索欄のみ入力時
      @sakes = Sake.where("name LIKE ? ",'%' + params[:search] + '%').page(params[:page]) #部分検索結果
    else
      #全て入力時
      @search_tag_id = params[:search_tag_id] #絞り込み結果
      @sakes = Sake.where("name LIKE ? ",'%' + params[:search] + '%').where(tag_id: @search_tag_id).page(params[:page])
      #+部分検索結果
    end
  end

  def show
    @sake = Sake.find(params[:id]) #該当する日本酒
    @comments = Comment.where(sake_id: @sake.id) #日本酒のコメントを検索
  end

  def edit
    @sake = Sake.find(params[:id]) #該当する日本酒
  end

  def update
    @sake = Sake.find(params[:id]) #該当する日本酒
    if @sake.update(sake_params)
      redirect_to admin_sake_path(@sake.id), notice: "お酒の情報を変更しました。"
    else
      render :edit
    end
  end

  def destroy
    @sake = Sake.find(params[:id]) #該当する日本酒
    if @sake.is_active == false #日本酒が休売している場合
      @sake.destroy
      redirect_to admin_sakes_path, notice: "お酒の削除が完了しました。"
    else
      flash[:notice] = "このお酒はまだ販売しております。"
      render :edit
    end
  end

  private
  def sake_params
    params.require(:sake).permit(:name, :price, :explain, :image, :is_active, :tag_id)
  end
end
