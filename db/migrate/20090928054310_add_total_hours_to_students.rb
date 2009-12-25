class AddTotalHoursToStudents < ActiveRecord::Migration
  def self.up
    Student.all.each do |s|
      s.save!
    end
  end

  def self.down
  end
end
