require 'test_helper'

class AdminsControllerTest < ActionController::TestCase
  test 'login for admin' do
    @controller.make_admin!
    get :new
    assert_redirected_to root_path
  end

  test 'login for non admin' do
    get :new
    assert_select 'title', 'Login'
  end

  test 'logout for non admin' do
    get :destroy
    assert_redirected_to root_path
  end

  test 'logout for admin' do
    @controller.make_admin!
    get :destroy
    assert_redirected_to root_path
    assert !@controller.admin?
  end

  test 'create with wrong password' do
    post :create, Password: 'wrong'
    assert !@controller.admin?
    assert_redirected_to login_path
  end

  test 'create with right password' do
    post :create, Password: 'abc'
    assert @controller.admin?
    assert_redirected_to private_messages_path
  end
end