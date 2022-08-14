class Brewery::SakesController < ApplicationController
  def index
    @user = current_brewery
    if params[:search] == nil
      if params[:search_tag_id] == nil
        @sakes = @user.sakes
      else
        @sakes = Tag.find(params[:tag_id]).sakes.where(brewery_id: @user)
      end
    elsif params[:search_tag_id] == ""
      @sakes = Sake.where("name LIKE ? ",'%' + params[:search] + '%').where(brewery_id: @user)
    else
      @search_tag_id = params[:search_tag_id]
      @sakes = Sake.where("name LIKE ? ",'%' + params[:search] + '%').where(tag_id: @search_tag_id).where(brewery_id: @user)
    end
  end

  def new
    @sake = Sake.new
  end

  def create
    @sake = Sake.new(sake_params)
    @sake.brewery_id = current_brewery.id
    if @sake.save
      flash[:notice] = "お酒の登録が完了しました"
      redirect_to brewery_sake_path(@sake.id)
    else
      render :new
    end
  end

  def show
    @sake = Sake.find(params[:id])
    if @sake.is_active == false && @sake.brewery_id != current_brewery.id
      flash.now[:notice] = 'このお酒は現在販売しておりません。'
      @sakes = Sake.all
      render :index
    end
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

  private
  def sake_params
    params.require(:sake).permit(:name, :price, :explain, :image, :is_active, :tag_id)
  end
end
