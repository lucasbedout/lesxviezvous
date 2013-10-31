class UsersController < ApplicationController
	def show
	end

	def follow
		@user = User.find_by_uid(params[:user_id])

	    if current_user.follow? @user
	      current_user.unfollow @user
	    else
	      current_user.follow @user
	    end

	    respond_to do |format|
	      current_user.save!
	      format.js { render 'posts/validate' }
	    end 
	end
end