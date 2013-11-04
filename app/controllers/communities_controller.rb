class CommunitiesController < ApplicationController
	def index
		@communities = Community.all
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
end