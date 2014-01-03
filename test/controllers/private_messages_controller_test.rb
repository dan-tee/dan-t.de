require 'test_helper'

class PrivateMessagesControllerTest < ActionController::TestCase
  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create message' do
    name = 'person1'
    post :create, private_message: { name: name, message: 'hello'}
    assert PrivateMessage.find_by_name(name)
  end

  test 'should show messages' do
    @controller.make_admin!
    PrivateMessage.create( name: 'person2', message: 'test test test')
    get :index
    assert_not_nil assigns(:messages)
  end
end
