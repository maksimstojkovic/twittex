class LikesController < ApplicationController
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :show_errors

  def create
    if Like.exists?(like_params)
        render_frame status: :conflict
    else
      @like = Like.new(like_params)
      
      if @like.save
        render_frame
      else
        render_frame status: :unprocessable_entity
      end
    end
  end

  def destroy
    @like = Like.find_by(like_params)
    if @like && @like.destroy
      render_frame
    else
      show_errors
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def like_params
      p = params.require(:like).permit(:post)
      { post: Post.find(p[:post]), user: current_user }
    end

    def render_frame(**args)
      render partial: "like_button",
        locals: { post: follow_params[:post] },
        **args
    end

    def show_errors(exception = nil)
      flash.now[:error] = "An unexpected error occurred."
      render_flash
    end
end
