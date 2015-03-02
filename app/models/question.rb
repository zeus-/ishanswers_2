class Question < ActiveRecord::Base
  
#  has_attached_file :image, styles: { :medium => "300x300>", :thumb => "100x100>" }, default_url: ActionController::Base.helpers.asset_path("missing_:style.png")
#  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_one :question_detail, dependent: :destroy
  has_many :answers, dependent: :destroy
  
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations
  
  has_many :votes, dependent: :destroy
  has_many :voted_users, through: :votes, source: :user
 
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  #added in bootcamp
  has_many :likes, dependent: :nullify
  has_many :liked_users, through: :likes, source: :user
  
  validates :title, presence: true, uniqueness: true 
  validates_presence_of :description, message: "must be present"
  
  default_scope order("created_at DESC")
  #last_x_days added during bootcamp
   # scope :last_days, -> { |x| where("created_at > ?", x.days.ago) }  
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
  
  #added in bootcamp
  def user_first_name
    user.first_name if user
  end

  def increment_view_count
    self.view_count ||= 0
    self.view_count += 1
    self.save
  end
  #bootcammp
  def likes_count
    likes.count
  end
  private
    def capitalize_title
      self.title.capitalize!
    end
    def set_default_vote
      self.vote_count ||= 0
    end
end
