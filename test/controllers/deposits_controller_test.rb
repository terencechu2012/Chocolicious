require 'test_helper'

class DepositsControllerTest < ActionController::TestCase
  test "should get addremark" do
    get :addremark
    assert_response :success
  end

  test "should get clubdeposits" do
    get :clubdeposits
    assert_response :success
  end

  test "should get editdeposit" do
    get :editdeposit
    assert_response :success
  end

  test "should get newdeposit" do
    get :newdeposit
    assert_response :success
  end

end
