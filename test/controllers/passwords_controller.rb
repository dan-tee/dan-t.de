require 'test_helper'

class PasswordsControllerTest < ActionController::TestCase
  test 'password file presensce' do
    assert @controller.password_file_exists?
  end

  test 'get new for existing password file' do
    @controller.stub(:password_file_exists?, true) do
      get :new
      assert_redirected_to root_path
    end
  end

  test 'get new for not existing password file' do
      @controller.stub(:password_file_exists?, false) do
      get :new
      assert_response :success
      assert_select 'title', 'Set Password'
    end
  end

  test 'create with wrong confirmation' do
    @controller.stub(:password_file_exists?, false) do
      post :create, Password: 'abc', Confirmation: 'abc '
      assert_redirected_to new_password_path
    end
  end

  test 'create with right confirmation' do
    @controller.stub(:password_file_exists?, false) do
      @controller.stub(:set_password!, nil) do
        post :create, Password: 'abc', Confirmation: 'abc'
        assert_redirected_to root_path
      end
    end
  end
end
