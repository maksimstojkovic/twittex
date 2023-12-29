class FollowsController < ApplicationController
  before_action :authenticate_user!

  # POST /follows
  def create
    @create_params = follow_params.to_h.merge({ follower: current_user, accepted: false })
    @follow = Follow.new(@create_params)

    if @follow.save
      redirect_to @follow, notice: "Follow was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /follows/1
  def destroy
    @follow = Follow.find_by(followee: follow_params[:followee], follower: current_user)
    @follow.destroy!
    redirect_to follows_url, notice: "Follow was successfully destroyed.", status: :see_other
  end

  private
    # Only allow a list of trusted parameters through.
    def follow_params
      params.require(:follow).permit(:followee)
    end
end
