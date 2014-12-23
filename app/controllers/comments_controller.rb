class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @answer = Answer.find(params[:answer_id])
    @comment = @answer.comments.new(cmnt_params)
    if @comment.save
      redirect_to @answer.question, notice: "Cmnt created!"
    else
      render @answer.question, notice: "Error"
    end
    
  end
  private
    def cmnt_params
      params.require(:comment).permit([:body])
    end
end
