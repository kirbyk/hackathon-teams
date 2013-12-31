require 'test_helper'

class HackersControllerTest < ActionController::TestCase
  setup do
    @hacker = hackers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hackers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hacker" do
    assert_difference('Hacker.count') do
      post :create, hacker: { email: @hacker.email, fname: @hacker.fname, github: @hacker.github, lname: @hacker.lname, tshirt_size: @hacker.tshirt_size, why: @hacker.why }
    end

    assert_redirected_to hacker_path(assigns(:hacker))
  end

  test "should show hacker" do
    get :show, id: @hacker
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hacker
    assert_response :success
  end

  test "should update hacker" do
    patch :update, id: @hacker, hacker: { email: @hacker.email, fname: @hacker.fname, github: @hacker.github, lname: @hacker.lname, tshirt_size: @hacker.tshirt_size, why: @hacker.why }
    assert_redirected_to hacker_path(assigns(:hacker))
  end

  test "should destroy hacker" do
    assert_difference('Hacker.count', -1) do
      delete :destroy, id: @hacker
    end

    assert_redirected_to hackers_path
  end
end
