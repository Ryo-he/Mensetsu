class CommentsController < ApplicationController
  def create
    experience = Experience.find(params[:experience_id])
    comment = current_user.comments.new(comment_params)
    comment.experience_id = experience.id
    comment.save
    redirect_to experience_path(experience)
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to experience_path(params[:experience_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:experience_comment)
  end
end

