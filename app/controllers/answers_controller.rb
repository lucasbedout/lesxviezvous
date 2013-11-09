class AnswersController < ApplicationController
	def new
	    @answer = Answer.new

	    respond_to do |format|
	      format.html # new.html.erb
	      format.json { render json: @answer }
	    end
	end

	  # GET /answers/1/edit
	def edit
	   @answer = answer.find(params[:id])
	end

	  # answer /answers
	  # answer /answers.json
	def create
	    @answer = Answer.new(params[:answer]) # params : content, category, source
	    @answer.user_id = current_user.id
	    @answer.question_id = params[:question]

	    respond_to do |format|
	      if @answer.save
	        format.js { render 'create'}
	        format.json { render json: @answer, status: :created, location: @answer }
	      else
	        redirect_to :back, :flash => { :error => 'Impossible'}
	        format.json { render json: @answer.errors, status: :unprocessable_entity }
	      end
	    end
	end

	def vote
		@answer = Answer.find(params[:answer_id])
		@answer.upvotes += 1

		respond_to do |format|
			if @answer.save
				format.js { render 'vote'}
			end
		end
	end
end
