class FavoritesController < ApplicationController
  before_action :authenticate_user!, :find_q
  def create
    @favorite = @question.favorites.new
    @favorite.user = current_user
    if @favorite.save
      redirect_to @question, notice: "I love u too babeh"
    else
      render @question, alert: "sorry your favorite cant be processed"
    end
  end

  def destroy
    @favorite = current_user.favorites.find(params[:id])
    if @favorite.destroy 
      redirect_to @question, notice: "Go faq yourself"
    else
      render @question, alert: "your favorite cant be processed"
    end
  end
  private
    def find_q
      @question = Question.find(params[:question_id])
    end
end
