class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    redirect_to "/games/#{comment.game.id}"
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, game_id: params[:game_id])
  end
end
