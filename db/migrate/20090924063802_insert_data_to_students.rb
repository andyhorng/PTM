require "csv"
class <<Hash
  def create(keys, values)
    self[*keys.zip(values).flatten]
  end
end

class InsertDataToStudents < ActiveRecord::Migration
  def self.up
    add_column :students, :total_hours, :integer
    sp_array = Array.new

    first = true
    first_row = []

    CSV.open("#{RAILS_ROOT}/db/94u.csv","r") do |row|
      if first
        first = false
        first_row = row.to_a
      else
        result = Hash.create(first_row,row.to_a)
        sp_array << result
      end
    end

    sp_array.each do |r|
      r.symbolize_keys!
      s = Student.new(r.slice(:name, :department, :student_number))
      s.hours << Hour.new(r.except(:name, :department, :student_number))
      s.save!
    end

  end

  def self.down
    remove_column :students, :total_hours
  end
end
