class Shop::ShopsController < ApplicationController
  def show
    @user = current_shop
    favorites = Favorite.where(shop_id: @user.id)
    sakes = favorites.pluck(:sake_id)
    @sakes = Sake.where(id: sakes).page(params[:page])
    @breweries = Relationship.where(shop_id: @user.id).page(params[:page])
  end

  def edit
    @user = current_shop
  end

  def update
    @user = current_shop
    if @user.update(shops_params)
      flash.now[:notice] = '会員情報の変更が完了しました。'
      render :show
    else
      render :edit
    end
  end

  def close
    @user = current_shop
  end

  def withdraw
    @user = current_shop
    @user.update(is_enable: false)
    redirect_to root_path, notice: '会員情報の変更が完了いたしました。'
  end

  private

  def shops_params
    params.require(:shop).permit(:name, :image, :post, :address, :tel)
  end

  def ensure_guest_user
    @user = Shop.find(params[:id])
    if @user.name == "閲覧者"
      redirect_to shop_my_page_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
end
