class CommentsController < ApplicationController
 before_action :authenticate_user!
   def create
    @answer = Answer.find(params[:answer_id])
    @comment = @answer.comments.create(c_params)
   #  @comment.user = current_user
    if @comment.save
      redirect_to @answer.question, notice: "Yushadha says: 'Yipee!'"
    else
      flash.now[:alert] = "Yushadha says: 'Error! I cant save!'"
      render "questions/show"
    end
  end
  def destroy
    @answer = Answer.find(params[:answer_id])
    @comment = @answer.comments.find(params[:id])
    if @comment.destroy 
      # &&@comment.user = current_user
      redirect_to @answer.question, notice: "Cmnt destroyed!" 
    else
      flash.now[:alert] = "Yushadha says: 'No! I will not delete this cmnt"
      render "questions/show"
    end
  end
private
  def c_params
    params.require(:comment).permit([:body])
  end
end
