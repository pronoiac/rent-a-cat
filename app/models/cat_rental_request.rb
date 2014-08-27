class CatRentalRequest < ActiveRecord::Base
  STATUSES = %w{ PENDING APPROVED DENIED}
  
  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion: { in: STATUSES,
    message: "%{value} is not a recognized request status"}
  validate :overlapping_approved_requests
  
  belongs_to :cat
  
  def overlapping_requests
    # sort start dates and end dates together, and look for two in a row, 
    # start or end? 
    # go over requests. 
    # compare every request to current request: 
    # req: certain cat, and APPROVED
    # CatRentalRequest.instance.execute
    
    query = <<-SQL
    cat_rental_requests.id != :id AND (
      ((:start) BETWEEN cat_rental_requests.start_date AND cat_rental_requests.end_date)
    OR
      ((:end) BETWEEN cat_rental_requests.start_date AND cat_rental_requests.end_date)
    OR
      (cat_rental_requests.start_date BETWEEN :start AND :end)
    OR
      (cat_rental_requests.end_date BETWEEN :start AND :end))
    SQL
    self.cat.cat_rental_requests.where(query, id: self.id,
      :start => start_date, 
      :end => end_date
    ) 
    # does return self, btw. 
  end
  
  def overlapping_approved_requests
    # debugger
    overlap = overlapping_requests.where(status: "APPROVED")#"status = 'APPROVED'")
    return true if overlap.length == 0
    p overlap.to_a
    previously = overlap.select("start_date, end_date")
    errors[:base] << "Overlapping error: #{previously}"
  end
end
