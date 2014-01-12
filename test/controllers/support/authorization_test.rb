require 'test_helper'
require_relative '../../../app/controllers/support/authorization'

# this test is an instance of ActionView::TestCase to have cookies available
class AuthorizationTest < ActionView::TestCase
  include Authorization

  def setup
    create_user!
  end

  test 'make admin' do
    make_admin!
    assert admin?
    assert @is_admin
  end

  test 'delete admin' do
    make_admin!
    delete_admin
    assert !admin?
  end

  test 'check password with right password' do
    assert check_password 'abc'
  end

  test 'check password with woring password' do
    assert !check_password(' ', false)
    assert !check_password('abcd', false)
    assert !check_password(' abc', false)
  end

  test 'too quick password attempts' do
    check_password ''
    assert !(check_password 'abc')
  end

  test 'too many password attempts' do
    3.times { check_password '' }
    sleep 3
    assert !(check_password 'abc')
  end

  test 'wait after many password attempts' do
    3.times { check_password '' }
    sleep 4
    assert (check_password 'abc')
  end
end