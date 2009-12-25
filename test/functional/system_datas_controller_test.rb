require 'test_helper'

class SystemDatasControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  fixtures :administrators
  fixtures :system_datas
  fixtures :system_data_values

  setup :activate_authlogic

  def setup
    login_user = AdministratorSession.create(administrators(:andy))
  end


  test "the truth" do
    assert true
  end

  test "index" do
    get 'index'
    all_name = SystemData.all.collect{ |d| d.name }
    all_name.each do |n|
      assert_select "#content", /#{n}/
    end

    assert_select "#content form", SystemData.all.size

    all = SystemData.all
    all.each do |d|
      d.system_data_values.each do |v|
        assert_select "#content li", /#{v.value}/
      end
    end
  end

  test "create new data" do
    orig = SystemDataValue.all.size
    post :create, { :system_data_value => {:value => '123456789', :system_data_id => system_datas(:data1).id} }
    assert_equal orig + 1, SystemDataValue.all.size
    assert_equal '123456789', SystemDataValue.all.last.value
    assert_equal system_datas(:data1).id, SystemDataValue.all.last.system_data_id
    assert_redirected_to system_datas_url
  end

  test "destroy" do 
    old = SystemDataValue.all.size
    get :destroy, {:id => system_data_values(:value1).id}
    assert_equal old - 1, SystemDataValue.all.size

    assert_raise ActiveRecord::RecordNotFound do
      SystemDataValue.find(system_data_values(:value1).id)
    end

  end


end
