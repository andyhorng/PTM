class Student < ActiveRecord::Base
  has_many :hours
  # validate
  # column : name, student_number, id_number
  validates_presence_of :name, :student_number, :id_number 

  def total_hours
    total = 0
    self.hours.each do |hour|
      total += hour.total_hours
    end
    total
  end

end
