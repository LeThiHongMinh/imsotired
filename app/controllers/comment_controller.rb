class CommentsController < ApplicationController
  before_action :authorized
  before_action :set_comment, only: [:edit, :update, :show, :destroy]
  before_action :set_discussion, only: [:create, :edit, :show, :update, :destroy]

  def create
    @comment = @discussion.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      render json: { message: 'Comment was successfully created.', comment: @comment }
    else
      render json: { error: 'Comment did not save. Please try again.' }, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    render json: { message: 'Comment was successfully deleted.' }
  end

  def edit
    # no need to find @discussion again since set_comment already finds it
  end

  def update
    if @comment.update(comment_params)
      render json: { message: 'Comment was successfully updated.', comment: @comment }
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: { comment: @comment }
  end

  private

  def set_discussion
    @discussion = Discussion.find(params[:discussion_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end
end