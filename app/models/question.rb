class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  validates :title, presence: true, uniqueness: true 
  validates_presence_of :description, message: "must be present"
  
  default_scope order("title ASC")
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
