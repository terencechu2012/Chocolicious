require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  test "should get viewaccount" do
    get :viewaccount
    assert_response :success
  end

  test "should get viewcbdaccounts" do
    get :viewcbdaccounts
    assert_response :success
  end

  test "should get viewallaccounts" do
    get :viewallaccounts
    assert_response :success
  end

  test "should get deposit" do
    get :deposit
    assert_response :success
  end

  test "should get fundstransfer" do
    get :fundstransfer
    assert_response :success
  end

end
