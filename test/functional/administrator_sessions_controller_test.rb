require 'test_helper'


class AdministratorSessionsControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  setup :activate_authlogic

  fixtures :administrators

  test "the truth" do
    assert true
  end

  test "first to this site which not login." do
    get :new
    assert_response :success
    get students_url
    assert_redirected_to new_administrator_session_url
  end

  test "login form" do
    get :new
    assert_select "form#new_administrator_session"
  end

  test "login" do 
    login_user = administrators(:andy)
    post :create, {:administrator_session => {:login => login_user.login, :password => '0917436767'}}
    assert_redirected_to students_url
  end


  test "login with bad password" do
    login_user = administrators(:andy)
    post :create, {:administrator_session => {:login => login_user.login, :password => 'bad password'}}
    assert_response :success
    assert_template :new
  end

  test "logout" do 
    login_user = AdministratorSession.create(administrators(:andy))
    get :destroy
    assert_redirected_to new_administrator_session_url
  end
end
