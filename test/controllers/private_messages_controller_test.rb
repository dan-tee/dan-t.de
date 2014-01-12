require 'test_helper'

class PrivateMessagesControllerTest < ActionController::TestCase

  test 'get new' do
    get :new
    assert_response :success
    assert_select 'title', 'Contact'
  end

  test 'create message' do
    name = 'person'
    text = 'hello'
    post :create, private_message: { name: name, message: text}
    message = PrivateMessage.find_by_name(name)
    assert_not_nil message
    assert_equal name, message.name
    assert_equal text, message.message
  end

  test 'create message without name' do
    text = 'hello bla bla'
    post :create, private_message: { message: text}
    assert_nil PrivateMessage.find_by_message(text)
    assert_redirected_to contact_path
  end

  test 'create message without text' do
    name = 'person'
    post :create, private_message: { name: name }
    assert_nil PrivateMessage.find_by_name(name)
    assert_redirected_to contact_path
  end

  test 'show messages for admin' do
    name = 'person'
    message = 'test message'

    @controller.stub(:admin?, true) do
      PrivateMessage.create( name: name, message: message)
      get :index
    end
    assert_select 'span', name
    assert_select 'p', message
  end

  test 'show messages for non admin' do
    get :index
    assert_redirected_to root_path
  end

  test 'archive message for admin' do
    @controller.stub(:admin?, true) do
      name = 'person'
      post :create, private_message: { name: name, message: 'to delete'}
      message = PrivateMessage.find_by_name(name)

      patch :update, id: message.id

      assert PrivateMessage.find_by_name(name).archived?
    end
  end

  test 'destroy message for non admin' do
    name = 'person'
    post :create, private_message: { name: name, message: 'to delete'}
    message = PrivateMessage.find_by_name(name)

    patch :update, id: message.id

    assert_redirected_to root_path
    assert !PrivateMessage.find_by_name(name).archived?
  end
end
