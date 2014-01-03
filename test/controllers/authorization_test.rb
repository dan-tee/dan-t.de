require 'test_helper'
require_relative '../../app/controllers/authorization'

class AuthorizationTest < ActionView::TestCase
  include Authorization

  test 'make admin' do
    make_admin!
    assert admin?
  end

  test 'delete admin' do
    make_admin!
    delete_admin
    assert !admin?
  end
end