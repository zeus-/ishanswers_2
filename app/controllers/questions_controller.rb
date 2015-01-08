class QuestionsController < ApplicationController
  
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_q, only: [:edit, :update, :destroy, :vote_up, :vote_down]
  def index    
    @recent_questions = Question.recent(3)
    @questions = Question.all
  end
  
  def new  
    #renders the new Q page 
    @question = Question.new
  end

  def create    
    # handles the action create when pressing submit on the new Q page
    #@question = Question.new(question_params)
     @question = current_user.questions.new(question_params)
    if @question.save
      redirect_to questions_path, notice: "Your Q was created successfully"
    else
      flash.now[:alert] = "Please correct the form"
      render :new
    end
  end

  def show
    # renders the show page for the question passed
    @question = Question.find(params[:id] || params[:question_id])
    @answer = Answer.new 
    @answers = @question.answers.ordered_by_creation
    #prevent undefined method `vote_for' for nil:NilClass when user is not signed in
    #changed jan 6
    @comment = Comment.new 
    @comments = @answer.comments.recent_ten
    if user_signed_in? 
      @vote = current_user.vote_for(@question) || Vote.new 
      @favorite = current_user.favorite_for(@question) || Favorite.new
    else
      @vote = Vote.new
      @favorite = Favorite.new
    end
  end

  def edit
    # renders the edit page for the question passed
    redirect_to root_path unless can? :edit, @question
  end

  def update
    # handles the update action when sumbitted in the edit page
    if @question.update_attributes(question_params) 
      redirect_to @question, notice: "Updated successfully"
    else
      flash.now[:alert] = "Update failed"
      render :edit
    end
  end
  
  def destroy
    if @question.destroy 
      redirect_to questions_path, notice: "Q deleted through '@question, method: :delete'"
    else
      flash.now[:alert] = "Cant delete this Q"
      render @question  
    end
  end

  #def vote_up
   # @question.increment!(:vote_count)
   # session[:has_voted] = true
   # redirect_to @question
  #end

  #def vote_down
   # @question.decrement!(:vote_count)
   # session[:has_voted] = true
   # redirect_to @question
  # end

  private
    def question_params
      question_params = params.require(:question).permit([:title, :description, {category_ids: []}, :image])
    end
    def find_q
     # @question = Question.find(params[:id])
     #  @question = current_user.questions.find_by_id(params[:id])
       @question = current_user.questions.find_by_id(params[:id])
       redirect_to root_path, alert: "Access denied, foo" unless @question
    end
end
