class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  def destroy
    @comment = Comment.find_by(id: params[:id], sake_id: params[:sake_id])
    #該当するコメントを検索
    @comment.destroy
    sake = Sake.find(params[:sake_id]) #コメントの親の日本酒
    @comments = sake.comments #該当するコメント
  end
end
