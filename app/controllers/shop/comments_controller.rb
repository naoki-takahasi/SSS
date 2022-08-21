class Shop::CommentsController < ApplicationController
  def create
    sake = Sake.find(params[:sake_id])
    @comment = current_shop.comments.new(sake_params)
    @comment.sake_id = sake.id
    @comment.save
    @comments = sake.comments.where(shop_id: current_shop)
  end

  def destroy
    @comment = Comment.find_by(id: params[:id], sake_id: params[:sake_id])
    @comment.destroy
    sake = Sake.find(params[:sake_id])
    @comments = sake.comments.where(shop_id: current_shop)
  end

  private

  def sake_params
    params.require(:comment).permit(:comment)
  end
end
