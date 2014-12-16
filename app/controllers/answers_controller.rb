class AnswersController < ApplicationController
  before_action :find_q
  def create
    @answer = @question.answers.new(answer_params)
    if @answer.save
      redirect_to @question, notice: "Answer created successfully"
    else
      redirect_to @question, notice: "Please correct your answer"
    end
    #code broke when implementibg partial render @answers in view :(
  end
  def destroy
    @answer = @question.answers.find(params[:id])
    if @answer.destroy
      redirect_to @question, notice: "Answer deleted!"
    else
      redirect_to @question, error: "We had trouble deleting this answer"
    end
  end
  private
    def answer_params
      params.require(:answer).permit([:body])
    end
    def find_q
      @question = Question.find(params[:question_id])
    end
end
