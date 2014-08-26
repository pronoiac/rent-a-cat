class Cat < ActiveRecord::Base

  CAT_COLORS = %w{black gray white brown orange}

  validates :name, presence: true
  validates_numericality_of :age
  validate :color, inclusion: { in: CAT_COLORS,
    message: "%{value} is not a recognized color"}
  validates :sex, inclusion: { in: %w(M F),
    message: "%{value} is not a recognized sex"}

  
  def self.colors
    CAT_COLORS
  end

  private
  
end

