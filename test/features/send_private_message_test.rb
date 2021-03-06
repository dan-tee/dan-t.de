require 'test_helper'

class SendPrivateMessageTest < Capybara::Rails::TestCase
  test 'Send message' do
    name = 'Person'
    email = 'person@example.com'
    text = 'test message'

    visit contact_path
    fill_in 'Name',    with: name
    fill_in 'Email',   with: email
    fill_in 'Message', with: text
    click_button 'Send'

    message = PrivateMessage.find_by_name(name)
    assert_not_nil message
    assert_equal name, message.name
    assert_equal email, message.email
    assert_equal text, message.message
  end

  test 'Message without email' do
    name = 'Person'
    text = 'test message'

    visit contact_path
    fill_in 'Name',    with: name
    fill_in 'Message', with: text
    click_button 'Send'

    message = PrivateMessage.find_by_name(name)
    assert_not_nil message
    assert_equal name, message.name
    assert_equal text, message.message
  end

  test 'Message without name' do
    text = 'test message'

    visit contact_path
    fill_in 'Message', with: text
    click_button 'Send'

    assert_selector 'h1', { text: 'Contact me' }
    assert_selector '.alert-danger', { text: 'not' }
    assert_selector '.field_with_errors', { text: 'Name' }
    assert_equal find_field('private_message_message').value, text
  end
end
