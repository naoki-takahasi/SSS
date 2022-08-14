class Admin::BreweriesController < ApplicationController
  def index
    @users = Brewery.all
  end

  def show
    @user = Brewery.find(params[:id])
    @sakes = @user.sakes
  end

  def edit
    @user = Brewery.find(params[:id])
  end

  def update
    @user = Brewery.find(params[:id])
    if @user.update(breweries_params)
      flash.now[:notice] = '会員情報の変更が完了しました。'
      render :show
    else
      render :edit
    end
  end

  def destroy
    @user = Brewery.find(params[:id])
    if @user.is_enable == false
      @user.destroy
      flash[:notice] = "会員の削除が完了しました"
      @users = Brewery.all
      render :index
    else
      flash[:notice] = "この酒造は営業しております"
      render :edit
    end
  end


  private

  def breweries_params
    params.require(:brewery).permit(:name, :image, :post, :address, :tel)
  end
end
