class FriendshipController < ApplicationController

    def new
        @friendship = Friendship.new
    end

    def create
        @friendship = current_user.friendships.build(friend_id: params[:user_id])
        if @friendships.save
            redirect_to users_path, notice: 'Succesfully sent friend request'
        else
            redirect_to users_path, notice: 'Unable to save friend request, try again at a later time'
        end
    end

    def destroy
        @user = User.find(params[:id])
        @friendship = current_user.inverse_friendships.find { |friendship| friendship.user == @user}
        @friendship.destroy
        redirect_to users_path, notice "Removed #{@user.name} as friend" 
    end

    def approve
        @user = User.find(params[:user_id])
        @friendship = current_user.inverse_friendships.find { |friendship| friendship.user == @user }
        @friendship.status = "confirmed"
        if @friendship.save
            redirect_to users_path(params[:user_id]), notice "Friendship with #{@user.name} confirmed"
        end
    end

    def pending
        @user = User.find(params[:user_id])
        @friendship = @user.inverse_friendships.find { |friendships| friendships.user == current_user }
        @friendship.status = 'to_confirm'
        @friendship = current_user.inverse_friendships.find { |friendship| friendship.user == @user }
        @friendship.status = 'pending'
        if @friendship.save
            redirect_to users_path(params[:user_id]), notice "Friendship request sent to #{@user.name}"
        end
    end


end