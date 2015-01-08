class CommentsController < ApplicationController
 before_action :authenticate_user!
   def create
    @answer = Answer.find(params[:answer_id])
    @comment = @answer.comments.new(c_params)
    @comment.user = current_user
    respond_to do |format|  
    if @comment.save
      format.html { redirect_to @answer.question, notice: "Yushadha says: 'Yipee!'" }
      format.js { render }
    else
      format.html { redirect_to @answer.question, alert: "Yushadha says: 'Error! I cant save!'" }
      format.js { render js: "alert('Yushadha says: ALERT! ALERT! I cant save! Comment must be over 3 chracters!');" } 
    end
  end
 end

  def destroy
    @answer = Answer.find(params[:answer_id])
    @comment = @answer.comments.find(params[:id])
    if @comment.destroy && @comment.user = current_user
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
