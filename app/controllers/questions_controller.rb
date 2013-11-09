class QuestionsController < ApplicationController
	def new
	    @question = Question.new

	    respond_to do |format|
	      format.html # new.html.erb
	      format.json { render json: @question }
	    end
	end

	  # GET /questions/1/edit
	def edit
	   @question = Question.find(params[:id])
	end

	  # question /questions
	  # question /questions.json
	def create
	    @question = Question.new(params[:question]) # params : content, category, source
	    @question.user_id = current_user.id
	    @question.community_id = params[:community]

	    respond_to do |format|
	      if @question.save
	        format.html { redirect_to Community.find(params[:community]), notice: 'question was successfully created.' }
	        format.json { render json: @question, status: :created, location: @question }
	      else
	        format.html { render action: "new" }
	        format.json { render json: @question.errors, status: :unprocessable_entity }
	      end
	    end
	end

	def vote
		@question = Question.find(params[:question_id])
		@question.upvotes += 1

		respond_to do |format|
			if @question.save
				format.js { render 'vote'}
			end
		end
	end

	def print_answers
		@question = Question.find(params[:question_id])
		respond_to do |format| 
			format.js { render 'print_answers' }
		end
	end

end
