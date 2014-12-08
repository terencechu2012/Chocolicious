require 'test_helper'

class ClubusersControllerTest < ActionController::TestCase
  setup do
    @clubuser = clubusers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:clubusers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create clubuser" do
    assert_difference('Clubuser.count') do
      post :create, clubuser: { clubid: @clubuser.clubid, role: @clubuser.role, userid: @clubuser.userid }
    end

    assert_redirected_to clubuser_path(assigns(:clubuser))
  end

  test "should show clubuser" do
    get :show, id: @clubuser
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @clubuser
    assert_response :success
  end

  test "should update clubuser" do
    patch :update, id: @clubuser, clubuser: { clubid: @clubuser.clubid, role: @clubuser.role, userid: @clubuser.userid }
    assert_redirected_to clubuser_path(assigns(:clubuser))
  end

  test "should destroy clubuser" do
    assert_difference('Clubuser.count', -1) do
      delete :destroy, id: @clubuser
    end

    assert_redirected_to clubusers_path
  end
end
