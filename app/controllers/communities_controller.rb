class CommunitiesController < ApplicationController
	def index
		@communities = Community.all
	end

	def show
		@community = Community.find(params[:id])
		@blogline = @community.blogline(:last_shown_obj_id => nil, :limit => 10, :for_user => nil)
	end

	def create
	    @community = Community.create :name => params[:name], :owner_id => current_user.id, :public => params[:privacy]
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

	  def join 
	  	@community = Community.find(params[:community_id])

	  	if @community.public == true
	  		current_user.join @community
	  	else
	  		current_user.request_invitation @community
	  	end

	  	 respond_to do |format|
	        format.html { redirect_to root_path, notice: 'OK' }
	        format.json { render json: @community, status: :created, location: @community }
	    end
	  end
end