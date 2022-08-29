class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @tag = Tag.new
    if params[:search] == nil #検索欄未入力
      @tags = Tag.all #タグ全表示
    else
      @tags = Tag.where("name LIKE ? ",'%' + params[:search] + '%') #部分検索結果
    end
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to admin_tags_path, notice: "タグの登録が完了しました。"
    else
      @tags = Tag.all #タグ全表示
      render :index
    end
  end

  def edit
    @tag = Tag.find(params[:id]) #該当するタグ
  end

  def update
    @tag = Tag.find(params[:id]) #該当するタグ
    if @tag.update(tag_params)
      redirect_to admin_tags_path, notice: "タグの名称を変更しました。"
    else
      render :edit
    end
  end

  def destroy
    @tag = Tag.find(params[:id]) #該当するタグ
    @tag.destroy
    redirect_to admin_tags_path, notice: "タグの削除が完了しました。"
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

end
