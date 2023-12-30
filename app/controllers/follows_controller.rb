class FollowsController < ApplicationController
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :show_errors

  def create
    if Follow.exists?(follow_params)
        render_frame status: :conflict
    else
      @follow = Follow.new(followee_id: follow_params[:followee], follower: current_user)
      
      if @follow.save
        render_frame
      else
        render_frame status: :unprocessable_entity
      end
    end
  end

  def destroy
    @follow = Follow.find_by(followee_id: follow_params[:followee], follower: current_user)
    if @follow && @follow.destroy
      render_frame
    else
      show_errors
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def follow_params
      params.require(:follow).permit(:followee)
    end

    def render_frame(**args)
      render partial: "follow_button",
        locals: { user: User.find(follow_params[:followee]) },
        **args
    end

    def show_errors(exception = nil)
      flash.now[:error] = "An unexpected error occurred."
      render_flash
    end
end
