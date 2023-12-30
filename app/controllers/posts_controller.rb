class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[ show destroy ]
  before_action :is_authorised, only: %i[ destroy ]

  # GET /posts
  def index
    @posts = Post.sort_desc
  end

  # GET /posts/1
  def show
    @comments = @post.comments.all
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      turbo_stream
    else
      render partial: 'posts/form', locals: { post: @post }, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy!
    redirect_to user_url(current_user), notice: "Post was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:body).to_h.merge({ author: current_user })
    end

    def is_authorised
      if current_user != @post.author
        head :forbidden
        return
      end
    end
end
