require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should login" do
    u = users(:one)
    post :create, :name => u.name, :password => "secret"
    assert_redirected_to admin_url
    assert_equal u.id, session[:user_id]
  end

  test "should fail login" do
    u = users(:one)
    post :create, :name => u.name, :password => "wrong"
    assert_redirected_to login_url
  end

  test "should logout" do
    delete :destroy
    assert_redirected_to store_url
  end

end
