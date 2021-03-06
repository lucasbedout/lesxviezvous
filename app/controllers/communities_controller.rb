class CommunitiesController < ApplicationController
	def index
		@communities = Community.all
	end

	def show
		@community = Community.find(params[:id])
		@blogline = @community.blogline(:last_shown_obj_id => nil, :limit => 5, :for_user => nil)
		unless @blogline.blank?
			@last = @blogline.last.item_id_in_line
		else 
			@last = "none"
		end
		@questionline = @community.questions 
	end

	def new
		@community = Community.new
	end

	def create
	    @community = Community.create :name => params[:name], :owner_id => current_user.id, :public => params[:privacy]
	    @community.category_id = params[:category]
	    respond_to do |format|
	      if @community.save
	        format.html { redirect_to @community, notice: 'community was successfully created.' }
	        format.json { render json: @community, status: :created, location: @community }
	      else
	        format.html { render action: "new" }
	        format.json { render json: @community.errors, status: :unprocessable_entity }
	      end
	    end
	end

	def edit
		@community = Community.find(params[:id])
	end

	def update
	    @community = Community.find(params[:id])
		    respond_to do |format|
		      if @community.update_attributes(params[:community])
		        format.html { redirect_to @community, notice: 'community was successfully updated.' }
		        format.json { head :no_content }
		      else
		        format.html { render action: "edit" }
		        format.json { render json: @community.errors, status: :unprocessable_entity }
		      end
		    end
	end

	 def join 
	  	@community = Community.find(params[:community_id])

	  	if @community.public == true
	  		current_user.join @community
	  	else
	  		current_user.request_invitation @community
	  	end

	  	 respond_to do |format|
	        format.html { redirect_to @community, notice: 'Merci de nous avoir rejoint' }
	        format.json { render json: @community, status: :created, location: @community }
	    end
	end

	def leave 
	  	@community = Community.find(params[:community_id])
	  	 respond_to do |format|
	  	 	current_user.leave @community
	        format.html { redirect_to @community, notice: 'Merci de nous avoir rejoint' }
	        format.json { render json: @community, status: :created, location: @community }
	    end
	end

	def ban
		@community = Community.find(params[:community_id])
		@user = User.find(params[:user])
		if @community.admins_row.include? current_user.id and @user != current_user
			current_user.kick :user => @user, :from_community => @community
			redirect_to @community, :flash => { :notice => 'Utilisateur banni'}
		else 
			redirect_to @community, :flash => { :error => 'Banissement impossible'}
		end
	end

	def mute
		@community = Community.find(params[:community_id])
		@user = User.find(params[:user])
		if @community.admins_row.include? current_user.id and @user != current_user
			current_user.mute :user => @user, :in_community => @community
			redirect_to @community, :flash => { :notice => 'Utilisateur muet'}
		else 
			redirect_to @community, :flash => { :error => 'Erreur, utilisateur actif'}
		end
	end
end