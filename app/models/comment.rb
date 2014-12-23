class Comment < ActiveRecord::Base
  validates :body, presence: true, length: {minimum: 3} 
  belongs_to :answer
  scope :recent_ten, -> { order("created_at DESC").limit(10) } 
  def sanitize
    self.body.squeeze!(" ").strip!
  end
end
