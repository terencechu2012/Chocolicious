require 'test_helper'

class EreceiptsControllerTest < ActionController::TestCase
  test "should get newreceipt" do
    get :newreceipt
    assert_response :success
  end

  test "should get viewsentreceipt" do
    get :viewsentreceipt
    assert_response :success
  end

end
