class CommentsController < ApplicationController
  def top
    @comments = Comment.includes(:user).by_user.most_used(10).
      where(created_at: (7.days.ago..DateTime.now)).order('count DESC')
  end

  def create
    Comment.create(comment_params.merge(user_id: current_user.id))
    redirect_to movie_path(comment_params[:movie_id])
  end

  def destroy
    comment = Comment.find(params[:id])
    movie = comment.movie
    comment.destroy
    redirect_to movie_path(movie.id)
  end

  def comment_params
    params.require(:comments).permit(:comment, :movie_id)
  end
end
