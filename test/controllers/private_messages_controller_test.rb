require 'test_helper'

class PrivateMessagesControllerTest < ActionController::TestCase
  test 'get new' do
    get :new
    assert_response :success
    assert_select 'title', 'Contact'
  end

  test 'create message' do
    name = 'person1'
    post :create, private_message: { name: name, message: 'hello'}
    assert PrivateMessage.find_by_name(name)
  end

  test 'show messages for admin' do
    name = 'person2'
    message = 'test message'

    @controller.make_admin!
    PrivateMessage.create( name: name, message: message)
    get :index
    assert_select 'span', name
    assert_select 'p', message
  end

  test 'show messages for non admin' do
    get :index
    assert_redirected_to root_path
  end

  test 'destroy message for admin' do
    @controller.make_admin!
    name = 'person3'
    post :create, private_message: { name: name, message: 'to delete'}
    message = PrivateMessage.find_by_name(name)

    patch :update, id: message.id

    assert PrivateMessage.find_by_name(name).archived?
  end

  test 'destroy message for non admin' do
    name = 'person3'
    post :create, private_message: { name: name, message: 'to delete'}
    message = PrivateMessage.find_by_name(name)

    patch :update, id: message.id

    assert_redirected_to root_path
    assert !PrivateMessage.find_by_name(name).archived?
  end
end
