class Shop::SakesController < ApplicationController
  def index
    if params[:search] == nil
      if params[:search_tag_id] == nil
        @sakes = Sake.where(is_active: true).page(params[:page])
      else
        @sakes = Tag.find(params[:tag_id]).sakes.where(is_active: true).page(params[:page])
      end
    elsif params[:search_tag_id] == ""
      @sakes = Sake.where("name LIKE ? ",'%' + params[:search] + '%').where(is_active: true).page(params[:page])
    else
      @search_tag_id = params[:search_tag_id]
      @sakes = Sake.where("name LIKE ? ",'%' + params[:search] + '%').where(tag_id: @search_tag_id).where(is_active: true).page(params[:page])
    end
  end

  def show
    @sake = Sake.find(params[:id])
    if @sake.is_active == false
      flash.now[:notice] = 'このお酒は現在販売しておりません。'
      @sakes = Sake.where(is_active: true)
      render :index
    end
    @comment = Comment.new
    @comments = @sake.comments.where(shop_id: current_shop).page(params[:page])
  end
end
