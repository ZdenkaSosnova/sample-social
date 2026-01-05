module AuthenticationHelper
  def sign_in(user, password: 'password123')
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: password
    click_button 'Log in'
  end

  def sign_out
    click_link 'Log out'
  end
end

RSpec.configure do |config|
  config.append_before(:each, type: :system) do |example|
    if example.metadata[:signed_in]
      sign_in(current_user)
    end
  end
end