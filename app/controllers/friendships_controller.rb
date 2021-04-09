class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = current_user.friendships.build(friend_id: params[:user_id])
    if @friendship.save
      redirect_to users_path
    else
      redirect_to users_path, notice: 'Unable to save friend request, try again at a later time'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @friendship = current_user.inverse_friendships.find { |friendship| friendship.user == @user }
    @friendship.destroy
    redirect_to users_path, notice: "Removed #{@user.name} as friend"
  end

  def approve
    @user = User.find(params[:user_id])
    @friendship = current_user.inverse_friendships.find { |friendship| friendship.user == @user }
    @friendship.confirmed = true

    return unless @friendship.save

    current_user.friendships.create!(friend_id: @user.id, confirmed: true)

    redirect_to users_path(params[:user_id]), notice: "Friendship with #{@user.name} confirmed"
  end

  private

  def user
    @friend = User.find(params[:user_id])
  end
end
