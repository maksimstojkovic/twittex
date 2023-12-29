class FollowsController < ApplicationController
  before_action :authenticate_user!

  # POST /follows
  def create
    if Follow.exists?(follow_params)
      render json: { msg: "Already following user." }, status: :conflict
    else
      @follow = Follow.new(follow_params)
      
      if @follow.save
        @followee = follow_params[:followee]
        render partial: "follow_button", locals: { user: follow_params[:followee] }
      else
        render json: { msg: "Invalid parameters." }, status: :unprocessable_entity
      end
    end
  end

  # DELETE /follows/1
  def destroy
    @follow = Follow.find_by(follow_params)
    @follow.destroy!
    render partial: "follow_button", locals: { user: follow_params[:followee] }
  end

  private
    # Only allow a list of trusted parameters through.
    def follow_params
      followee_id = params.require(:follow).permit(:user)[:user]
      { followee: User.find(followee_id), follower: current_user }
    end
end
