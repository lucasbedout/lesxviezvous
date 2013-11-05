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

	def edit
		@user = User.find(params[:id])
	end

	def update
    @user = User.find(params[:id])
    if @user.provider == 'identity'
    	@identity = Identity.find(@user.uid)
    end

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end