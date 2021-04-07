class FriendshipsController < ApplicationController

    def new
        @friendship = Friendship.new
    end

    def create
        @friendship = current_user.friendships.build(friend_id: params[:user_id])
        if @friendship.save
            redirect_to users_path, notice: 'Succesfully sent friend request'
        else
            redirect_to users_path, notice: 'Unable to save friend request, try again at a later time'
        end
    end

    def destroy
        @user = User.find(params[:id])
        @friendship = current_user.inverse_friendships.find { |friendship| friendship.user == @user}
        @friendship.destroy
        redirect_to users_path, notice: "Removed #{@user.name} as friend" 
    end

    def approve
        @user = User.find(params[:user_id])
        @friendship = current_user.inverse_friendships.find { |friendship| friendship.user == @user }
        @friendship.confirmed = true
        if @friendship.save
            redirect_to users_path(params[:user_id]), notice: "Friendship with #{@user.name} confirmed"
        end
    end

    # def pending
    #     @user = User.find(params[:user_id])
    #     @friendship = @user.inverse_friendships.find { |friendship| friendship.user == current_user }
    #     @friendship.status = 'to_confirm'
    #     # puts "\n\n\n   FRIENDSHIP SIZE: #{@friendship}\n\n\n"
    #     @friendship = current_user.friendships.find { |friendship| friendship.user == @user }
    #     # puts "\n\n\n   FRIENDSHIP SIZE: #{@friendship}\n\n\n"
    #     @friendship.status = 'pending'
    #     if @friendship.save
    #         redirect_to users_path(params[:user_id]), notice: "Friendship request sent to #{@user.name}"
    #     end
    # end


end