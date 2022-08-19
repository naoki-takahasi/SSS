class Admin::CommentsController < ApplicationController
  def destroy
    @comment = Comment.find_by(id: params[:id], sake_id: params[:sake_id])
    @comment.destroy
  end
end
