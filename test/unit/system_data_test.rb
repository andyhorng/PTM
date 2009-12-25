require 'test_helper'

class SystemDataTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test "all values of a name" do 
    values = SystemData.all_values_of(system_datas(:data1).name)
    values2 = SystemData.all_values_of(system_datas(:data2).name)
    assert_equal 2, values.size
    assert_equal 1, values2.size
    assert values.include? system_data_values(:value1).value
    assert values.include? system_data_values(:value2).value
  end

end
