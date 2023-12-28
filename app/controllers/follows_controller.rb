class FollowsController < ApplicationController
  before_action :set_follow, only: %i[ show edit update destroy ]

  # GET /follows
  def index
    @follows = Follow.all
  end

  # GET /follows/1
  def show
  end

  # GET /follows/new
  def new
    @follow = Follow.new
  end

  # GET /follows/1/edit
  def edit
  end

  # POST /follows
  def create
    @follow = Follow.new(follow_params)

    if @follow.save
      redirect_to @follow, notice: "Follow was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /follows/1
  def update
    if @follow.update(follow_params)
      redirect_to @follow, notice: "Follow was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /follows/1
  def destroy
    @follow.destroy!
    redirect_to follows_url, notice: "Follow was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_follow
      @follow = Follow.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def follow_params
      params.require(:follow).permit(:follower_id, :followee_id, :accepted)
    end
end
