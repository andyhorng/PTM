require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  
  fixtures :hours

  def setup
    @andy = students(:andy)
  end

  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

#  test "total money of student" do 
#    assert_equal @andy.total_hours, hours(:andy_one).total_hours + hours(:andy_two).total_hours
#  end

  test "total hours after save" do 
    new_hour = Hour.new
    new_hour.total_hours = 1000
    @andy.hours << new_hour
    @andy.save
    assert_equal new_hour.total_hours + hours(:andy_one).total_hours + hours(:andy_two).total_hours, @andy.total_hours
  end
end
