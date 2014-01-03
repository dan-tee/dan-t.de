require 'test_helper.rb'

class PrivateMessageTest < ActiveSupport::TestCase
  before do
    @message ||= PrivateMessage.new
  end

  test 'attributes present' do
    assert @message.respond_to? :name
    assert @message.respond_to? :email
    assert @message.respond_to? :message
    assert @message.respond_to? :created_at
    assert @message.respond_to? :updated_at
    assert @message.respond_to? :archived
  end
end
