class Question < ActiveRecord::Base
  
  belongs_to :user
  has_one :question_detail, dependent: :destroy
  has_many :answers, dependent: :destroy
  
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations
  
  has_many :votes, dependent: :destroy
  has_many :voted_users, through: :votes, source: :user
  
  validates :title, presence: true, uniqueness: true 
  validates_presence_of :description, message: "must be present"
  
  default_scope order("created_at DESC")
  scope :recent, lambda { |x| order("created_at DESC").limit(x) }
  scope :recent_ten, -> { order("created_at DESC").limit(10) } 
    # the above scope does the same as below
    #   def self.recent(x)
    #     order("created_at DESC").limit(x)
    #   end
    #   def self.recent_10
    #     order("created_at DESC").limit(10)
    #   end
                                                        
  before_save :capitalize_title
  after_initialize :set_default_vote 

  private
    def capitalize_title
      self.title.capitalize!
    end
    def set_default_vote
      self.vote_count ||= 0
    end
end
