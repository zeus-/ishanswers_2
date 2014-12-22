class User < ActiveRecord::Base
  # Itnclude default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :questions
  has_many :answers
  
  has_many :votes, dependent: :destroy
  has_many :voted_questions, through: :votes, source: :question

  has_many :favorites, dependent: :destroy
  has_many :favorited_questions, through: :favorites, source: :question

  def favorite_for(q)
    Favorite.where(question: q, user: self).first
  end
  
  def vote_for(question)
    Vote.where(question: question, user:  self).first
  end
  
  def full_name
    if first_name || last_name
      "#{first_name} #{last_name}".squeeze.strip
    else
      email
    end
  end

end