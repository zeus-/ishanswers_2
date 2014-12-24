class CommentsController < ApplicationController
 before_action :authenticate_user!
   def create
    @answer = Answer.find(params[:answer_id])
    @comment = @answer.comments.create(c_params)
    if @comment.save
      redirect_to @answer.question
    else
      flash.now[:alert] = "yushadha says no"
      render "questions/show"
    end
  end
  def destroy
    @answer = Answer.find(params[:answer_id])
    @comment = @answer.comments.find(params[:id])
    if @comment.destroy
      flash.now[:notice] = "deleted q"
      redirect_to @answer.question 
    else
      flash.now[:alert] = "Coment deletd!"
      render "questions/show"
    end
  end
private
  def c_params
    params.require(:comment).permit([:body])
  end
end
