class Brewery::SakesController < ApplicationController
  def index
    @sakes = Sake.all
  end

  def new
    @sake = Sake.new
  end

  def create
    @sake = Sake.new(sake_params)
    if @sake.save
      flash[:notice] = "タグの登録が完了しました"
      redirect_to brewery_sake_path(@sake.id)
    else
      render :new
    end
  end

  def show
    @sake = Sake.find(params[:id])
  end

  def edit
    @sake = Sake.find(params[:id])
  end

  def update
    @sake = Sake.find(params[:id])
    if @sake.update(sake_params)
      flash[:notice] = "タグの名称を変更しました"
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
