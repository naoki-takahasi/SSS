class Shop::CommentsController < ApplicationController
  before_action :authenticate_shop!
  def create
    sake = Sake.find(params[:sake_id]) #コメントの親の日本酒
    @comment = current_shop.comments.new(sake_params) #ログインしている店舗を親としてコメントを作成
    @comment.sake_id = sake.id #コメントと日本酒を結びつける
    @comment.score = Language.get_data(sake_params[:comment]) #スコア算出(コメント管理用)
    @comment.save
    @comments = sake.comments.where(shop_id: current_shop)
  end

  def destroy
    @comment = Comment.find_by(id: params[:id], sake_id: params[:sake_id])
    #該当するコメントを検索
    @comment.destroy
    sake = Sake.find(params[:sake_id]) #コメントの親の日本酒
    @comments = sake.comments.where(shop_id: current_shop) #該当するコメントから店舗を検索
  end

  private

  def sake_params
    params.require(:comment).permit(:comment)
  end
end
