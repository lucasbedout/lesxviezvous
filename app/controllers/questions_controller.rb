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
end
