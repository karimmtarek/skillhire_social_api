class Api::UsersController < ApplicationController
  before_action :set_user, only: [:follow, :unfollow]

  def create
    user = User.new(user_params)

    if user.save
      render json: UserSerializer.new(user).serializable_hash, status: :ok
    else
      render json: {errors: user.errors}, status: :unprocessable_entity
    end
  end

  def follow
    user_to_follow = User.find(params[:id])

    if @user.follow_user(user: user_to_follow)
      head :ok
    else
      render json: {errors: @user.followers.last.errors}, status: :unprocessable_entity
    end
  end

  def unfollow
    user_to_unfollow = User.find(params[:id])

    if @user.unfollow_user(user: user_to_unfollow)
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def followers
    user = User.find(params[:id])
    render json: FollowerSerializer.new(user.followers).serializable_hash, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:name, :username)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
