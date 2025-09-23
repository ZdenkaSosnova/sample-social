require 'rails_helper'

RSpec.describe 'Deleting microposts', type: :system, signed_in: true do
  let(:current_user) { create(:user, name: 'John Doe') }

  it 'allows user to create their first micropost' do
    within('#navbar-menu') do
      click_link 'Home'
    end

    expect(page).not_to have_selector('.microposts li')

    fill_in 'Compose new micropost...', with: 'My first post!'
    click_button 'Post'

    within('.microposts') do
      expect(page).to have_selector('li', count: 1)
      expect(page).to have_content('My first post!')
    end
  end
end