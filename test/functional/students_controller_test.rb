require 'test_helper'

class StudentsControllerTest < ActionController::TestCase

  fixtures :administrators
  setup :activate_authlogic

  def setup
    @login = AdministratorSession.create(administrators(:andy))
  end

  test "the truth" do
    assert true
  end

  test "index" do
    get :index
    assert_template :index
    assert_select "table tr td", /#{students(:andy).name}/
    assert_select "table tr td", /#{students(:fred).name}/
    assert_select "table tr td", /#{students(:neet).name}/
  end

  test "index with searching" do 
    session[:searching] = true
    session[:search_string] = 'abcdefghijlnm'
    get :index
    assert_template :index
    assert_equal  I18n.t('flash.student.clear'), flash[:notice]
    assert_select '#content', /#{I18n.t('student.search.blank')}/
  end

  test "index with searching and search result" do 
    session[:searching] = true
    session[:search_string] = students(:andy).name
    get :index
    assert_select '#content table', /#{students(:andy).name}/
    assert_select '#content table', /#{students(:andy).total_hours}/
  end


  test "search for index" do 
    get :search_for_index, {:search_string => students(:andy).name}
    assert_redirected_to students_url
  end

  test "search for helper" do
    xhr(:post, :search_for_helper, {:search_string => students(:andy).name})
    assert_select "table tr", 1
    assert_select "table tr", /#{students(:andy).name}/
  end

  test "back" do 
    get :back
    assert_redirected_to students_url
  end

  test "" do
  end

end
