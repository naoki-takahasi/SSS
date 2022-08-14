class Brewery::BreweriesController < ApplicationController
  def show
    @user = current_brewery
    @sakes = @user.sakes
  end

  def edit
    @user = current_brewery
  end

  def update
    @user = current_brewery
    if @user.update(breweries_params)
      flash.now[:notice] = '会員情報の変更が完了しました。'
      render :show
    else
      render :edit
    end
  end

  def close
    @user = current_brewery
  end

  def withdraw
    @user = current_brewery
    @user.update(is_enable: false)
    redirect_to root_path, notice: '会員情報の変更が完了いたしました。'
  end

  private

  def breweries_params
    params.require(:brewery).permit(:name, :image, :post, :address, :tel)
  end
end
