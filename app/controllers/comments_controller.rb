class CommentsController < ApplicationController
  def top
    @comments = Comment.by_user.most_used(10).
      where(created_at: (7.days.ago..DateTime.now))
  end

  def create
    @comment = Comment.create(comment_params.merge(user_id: current_user.id))
    render js: "window.location.reload();"
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render js: "window.location.reload();"
  end

  def comment_params
    params.require(:comments).permit(:comment, :movie_id)
  end
end
