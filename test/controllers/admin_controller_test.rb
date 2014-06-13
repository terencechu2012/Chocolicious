require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get register" do
    get :register
    assert_response :success
  end

  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get chooserole" do
    get :chooserole
    assert_response :success
  end

  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get newrequest" do
    get :newrequest
    assert_response :success
  end

  test "should get viewrequests" do
    get :viewrequests
    assert_response :success
  end

end
