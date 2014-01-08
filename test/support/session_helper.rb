module SessionHelper
  def login!
    visit login_path
    fill_in 'Password', with: 'abc'
    click_button 'Log in'
  end
end