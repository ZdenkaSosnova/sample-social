require 'rails_helper'

RSpec.describe 'Micropost visibility', type: :system do
  let(:current_user) { create(:user, name: 'John Doe', password: 'password123') }
  let(:user) { create(:user) }
  let!(:micropost) { create(:micropost, user: user, content: 'Content') }

  before do
    visit login_path
    fill_in 'Email', with: current_user.email
    fill_in 'Password', with: 'password123'
    click_button 'Log in'
    expect(page).to have_content('John Doe')
  end

  it 'logged-in user viewing microposts on other user profile' do
    visit user_path(user)

    expect(page).not_to have_css("#micropost-#{micropost.id}")
    expect(page).not_to have_css("span.content", text: 'Content')
  end
end