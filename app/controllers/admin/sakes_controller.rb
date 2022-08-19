class Admin::SakesController < ApplicationController
  def index
    if params[:search] == nil
      if params[:search_tag_id] == nil
        @sakes = Sake.all
      else
        @sakes = Tag.find(params[:tag_id]).sakes
      end
    elsif params[:search_tag_id] == ""
      @sakes = Sake.where("name LIKE ? ",'%' + params[:search] + '%')
    else
      @search_tag_id = params[:search_tag_id]
      @sakes = Sake.where("name LIKE ? ",'%' + params[:search] + '%').where(tag_id: @search_tag_id)
    end
  end

  def show
    @sake = Sake.find(params[:id])
    @comments = Comment.where(sake_id: @sake.id)
    shops = @comments.pluck(:shop_id)
    @shops = Shop.find(shops)
  end

  def edit
    @sake = Sake.find(params[:id])
  end

  def update
    @sake = Sake.find(params[:id])
    if @sake.update(sake_params)
      flash[:notice] = "お酒の情報を変更しました"
      redirect_to brewery_sake_path
    else
      render :edit
    end
  end

  def destroy
    @sake = Sake.find(params[:id])
    if @sake.is_active == false
      @sake.destroy
      flash[:notice] = "お酒の削除が完了しました"
      @sakes = Sake.all
      render :index
    else
      flash[:notice] = "このお酒はまだ販売しております"
      render :edit
    end
  end

  private
  def sake_params
    params.require(:sake).permit(:name, :price, :explain, :image, :is_active, :tag_id)
  end
end
