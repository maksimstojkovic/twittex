class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    if Follow.exists?(follow_params)
        render_frame status: :conflict
    else
      @follow = Follow.new(follow_params)
      
      if @follow.save
        @followee = follow_params[:followee]
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
      followee_id = params.require(:follow).permit(:user)[:user]
      { followee: User.find(followee_id), follower: current_user }
    end

    def render_frame(**args)
      render(partial: "follow_button", locals: { user: follow_params[:followee] }, **args)
    end
end
