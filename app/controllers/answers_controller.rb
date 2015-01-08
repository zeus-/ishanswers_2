class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_q
  before_action :right_user

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @comment = Comment.new
    @comments = @answer.comments.recent_ten
    respond_to do |format|
      if @answer.save
        #Ishanswers2Mailer.notify_question_owner(@answer).deliver
        Ishanswers2Mailer.delay.notify_question_owner(@answer)
        format.html { redirect_to @question, notice: "Answer created successfully" }
        format.js { render }
      else
        format.html { redirect_to @question, notice: "Please correct your answer" }
        format.js { render js: "alert('Error, friend');" }
      end
    end
  end
  def destroy
    @answer = @question.answers.find(params[:id])
    respond_to do |format| 
      if @answer.user == current_user && @answer.destroy
        format.html { redirect_to @question, notice: "Answer deleted!" }
        format.js { render }
      else
        format.html { redirect_to @question, alert: "We had trouble deleting this answer" } 
        format.js { render js: "alert('you cant delete dis, friend');" }
      end
    end
  end
  private
    def answer_params
      params.require(:answer).permit([:body])
    end
    def comment_params
      params.require(:comment).permit([:body])
    end
    def find_q
      @question = Question.find(params[:question_id])
    end
    def right_user
      redirect_to root_path, alert: "Access denied, foo" unless current_user
    end
end
