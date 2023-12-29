class FollowsController < ApplicationController
  before_action :authenticate_user!

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
    @follow = Follow.find_by(follow_params)
    @follow.destroy!
    render_frame
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
end
