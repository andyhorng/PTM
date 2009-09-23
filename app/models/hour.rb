class Hour < ActiveRecord::Base
  belongs_to :student
  def total_money
    week_hours * hourly_money
  end
end
