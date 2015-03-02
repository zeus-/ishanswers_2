class User < ActiveRecord::Base
  # Itnclude default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  
  has_many :questions, dependent: :nullify
  has_many :answers, dependent: :nullify
  has_many :comments, dependent: :nullify
  
  has_many :votes, dependent: :destroy
  has_many :voted_questions, through: :votes, source: :question

  has_many :favorites, dependent: :destroy
  has_many :favorited_questions, through: :favorites, source: :question
  
  #added in bootcamp
  has_many :likes, dependent: :nullify
  has_many :liked_questions, through: :likes, source: :question 

  def favorite_for(q)
    Favorite.where(question: q, user: self).first
  end
  
  def vote_for(question)
    Vote.where(question: question, user: self).first
  end
  
  def full_name
    if first_name || last_name
      "#{first_name} #{last_name}".squeeze.strip
    else
      email
    end
  end
  def self.find_or_create_from_twitter(oauth_data)
    user = User.where(provider: :twitter, uid: oauth_data[:uid]).first

    unless user
      name = oauth_data["info"]["name"].split(" ")
      user = User.create!(first_name: name[0], 
                          last_name: name[1],
                          password: Devise.friendly_token[0, 20],
                          provider: :twitter,
                          uid: oauth_data["uid"])
    end
    user
  end

  def email_required?
    false
  end

end
