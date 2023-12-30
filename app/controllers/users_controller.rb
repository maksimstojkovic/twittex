class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where.not(id: current_user.id).sort_username
  end

  def show
    @user = User.find(params[:id])
    hash = Digest::MD5.hexdigest(@user.email.downcase)
    @img_src = "https://www.gravatar.com/avatar/#{hash}"
  end
end
