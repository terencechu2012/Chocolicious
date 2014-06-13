require 'test_helper'

class ChiefControllerTest < ActionController::TestCase
  test "should get changereserveslimit" do
    get :changereserveslimit
    assert_response :success
  end

  test "should get transferfunds" do
    get :transferfunds
    assert_response :success
  end

  test "should get modifyuserrole" do
    get :modifyuserrole
    assert_response :success
  end

  test "should get manageclub" do
    get :manageclub
    assert_response :success
  end

  test "should get pullback" do
    get :pullback
    assert_response :success
  end

  test "should get changeformula" do
    get :changeformula
    assert_response :success
  end

  test "should get allocate" do
    get :allocate
    assert_response :success
  end

  test "should get injectfunds" do
    get :injectfunds
    assert_response :success
  end

end
