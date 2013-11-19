class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		@blogline = @user.blogline(:last_shown_obj_id => nil, :limit => 6, :for_user => nil)
		unless @blogline.blank?
			@last = @blogline.last.item_id_in_line
		else
			@last = "none"
		end
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
	    if login(params[:user][:email], params[:user][:actual_password])
	    	params[:user].delete(:actual_password)
		    respond_to do |format|
		      if @user.update_attributes(params[:user])
		        format.html { redirect_to @user, notice: 'user was successfully updated.' }
		        format.json { head :no_content }
		      else
		        format.html { render action: "edit" }
		        format.json { render json: @user.errors, status: :unprocessable_entity }
		      end
		    end
		else 
			redirect_to edit_user_path(@user), :flash => { :error => 'Mot de passe actuel invalide'}
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