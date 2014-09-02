require 'test_helper'

class ReserveWithdrawalsControllerTest < ActionController::TestCase
  test "should get newrequest" do
    get :newrequest
    assert_response :success
  end

  test "should get viewrequest" do
    get :viewrequest
    assert_response :success
  end

  test "should get editrequest" do
    get :editrequest
    assert_response :success
  end

end
