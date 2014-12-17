class VotesController < ApplicationController
  before_action :authenticate_user! 
  before_action :find_q
  def create
    @vote = @question.votes.new(vote_params)
    @vote.user = current_user
    if @vote.save
      redirect_to @question, notice: "Thanks for voting, friend"
    else
      redirect_to @question, alert: "We had trouble processing your vote"
    end
  end
  
  def destroy
    @vote = current_user.votes.find(params[:id])
    if  @vote.destroy
      redirect_to @question, notice: "Vote removed!"
    else
      redirect_to @question, alert: "We had trouble removing your vote"
    end
  end

  def update
    @vote = current_user.votes.find(params[:id])
    if @vote.update_attributes(vote_params)
      redirect_to @question, notice: "Vote updated"
    else
      redirect_to @question, alert: "We had trouble removing your vote"
    end
  end

  private
    
    def find_q
      @question = Question.find(params[:question_id])
    end

    def vote_params
      params.require(:vote).permit(:is_up)
    end
end
