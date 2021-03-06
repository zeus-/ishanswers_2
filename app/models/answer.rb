class Answer < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :question
  has_many :comments, dependent: :destroy
  validates_presence_of :body
  scope :ordered_by_creation, -> { order("created_at DESC") } 
  before_save :capitalize
  
  def capitalize
    self.body.capitalize!
  end
  
  #added in bootcamp
  def user_first_name
    user.first_name if user
  end

end
