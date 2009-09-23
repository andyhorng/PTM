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

  test "total money of student" do 
    assert_equal @andy.total_hours, hours(:andy_one).total_hours + hours(:andy_two).total_hours
  end

end
