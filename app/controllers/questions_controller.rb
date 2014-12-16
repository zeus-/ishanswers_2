class QuestionsController < ApplicationController
  
  before_action :find_q, only: [:show, :edit, :update, :destroy, :vote_up, :vote_down]
  def index    
    @questions = Question.all
  end
  
  def new  
    #renders the new Q page 
    @question = Question.new
  end

  def create    
    # handles the action create when pressing submit on the new Q page
    @question = Question.new(question_params)
    if @question.save
      redirect_to questions_path, notice: "Your Q was created successfully"
    else
      flash.now[:error] = "Please correct the form"
      render :new
    end
  end

  def show
    # renders the show page for the question passed
    @answer = Answer.new
    @answers = @question.answers.ordered_by_creation
  end

  def edit
    # renders the edit page for the question passed
  end

  def update
    # handles the update action when sumbitted in the edit page
    if @question.update_attributes(question_params) 
      redirect_to @question, notice: "Updated successfully"
    else
      flash.now[:error] = "Update failed"
      render :edit
    end
  end
  
  def destroy
    if @question.destroy 
      redirect_to questions_path, notice: "Q deleted through '@question, method: :delete'"
    else
      render @question, error: "Cant delete this Q" 
    end
  end

  def vote_up
    @question.increment!(:vote_count)
    session[:has_voted] = true
    redirect_to @question
  end

  def vote_down
    @question.decrement!(:vote_count)
    session[:has_voted] = true
    redirect_to @question
  end

  private
    def question_params
      question_params = params.require(:question).permit([:title, :description])
    end
    def find_q
      @question = Question.find(params[:id])
    end
end
