require 'test_helper'

class ClaimsControllerTest < ActionController::TestCase
  test "should get newclaim" do
    get :newclaim
    assert_response :success
  end

  test "should get editclaim" do
    get :editclaim
    assert_response :success
  end

  test "should get viewclaim" do
    get :viewclaim
    assert_response :success
  end

end
