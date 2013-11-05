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

	def new
	    @user = User.new
	 end
	  
	def create
	  	@user = User.new(params[:user])
	  	@user.picture = 'http://www.yonima.com/img/upload/default_user.jpg'
	  	@user.picture_large = 'http://www.yonima.com/img/upload/default_user.jpg'
	    if @user.save
	      redirect_to root_url, :notice => "Inscription reussie"
	    else
	      redirect_to root_url, :notice => "Une erreur s'est produite !"
	    end
	  end
end