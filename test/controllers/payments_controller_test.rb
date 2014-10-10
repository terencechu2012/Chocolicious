require 'test_helper'

class PaymentsControllerTest < ActionController::TestCase
  test "should get newpayment" do
    get :newpayment
    assert_response :success
  end

  test "should get editpayment" do
    get :editpayment
    assert_response :success
  end

  test "should get viewpayment" do
    get :viewpayment
    assert_response :success
  end

end
