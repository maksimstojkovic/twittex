class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: %i[ destroy ]
  before_action :is_authorised, only: %i[ destroy ]
  rescue_from ActiveRecord::RecordNotFound, with: :show_errors

  # POST /comments
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      turbo_stream
    else
      render partial: "comments/form", locals: { comment: @comment }, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy!
    flash.now[:notice] = "Comment successfully deleted."
    turbo_stream
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:body, :post_id).to_h.merge({ author: current_user })
    end

    def is_authorised
      if current_user != @comment.author
        head :forbidden
        return
      end
    end
end
