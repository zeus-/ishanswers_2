class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_q
  before_action :right_user
  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    if @answer.save
      redirect_to @question, notice: "Answer created successfully"
    else
      redirect_to @question, notice: "Please correct your answer"
    end
    #code broke when implementibg partial render @answers in view :(
  end
  def destroy
    @answer = @question.answers.find(params[:id])
    if @answer.user == current_user && @answer.destroy
      redirect_to @question, notice: "Answer deleted!"
    else
      redirect_to @question, alert: "We had trouble deleting this answer"
    end
  end
  private
    def answer_params
      params.require(:answer).permit([:body])
    end
    def find_q
      @question = Question.find(params[:question_id])
    end
    def right_user
      redirect_to root_path, alert: "Access denied, foo" unless current_user
    end
end
