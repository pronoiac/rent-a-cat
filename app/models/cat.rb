class Cat < ActiveRecord::Base
  CAT_COLORS = %w{black gray white brown orange}

  validates :name, presence: true

  validates_numericality_of :age

  validate :color, inclusion: { in: CAT_COLORS,
    message: "%{value} is not a recognized color" }

  validates :sex, inclusion: { in: %w(M F),
    message: "%{value} is not a recognized sex" }
    
  # leaving these out, so bootstrapping the database is possible
  # validates :user_id, numericality: { only_integer: true }
  # validate :user_id, inclusion: { in: [User.find_by_id(:user_id)],
  #   message: "%{value} is not a valid user id" }
    
  # actual test: 
  validates :user, presence: true

  has_many :cat_rental_requests
  belongs_to :user
  
  def self.colors
    CAT_COLORS
  end
end

