class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@blogline = @user.blogline(:last_shown_obj_id => nil, :limit => 10, :for_user => nil)
	end

	def follow
		@user = User.find(params[:user_id])

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