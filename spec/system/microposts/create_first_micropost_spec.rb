require 'rails_helper'

# Collected locators in a common area for reusability and maintainability
navbar = '#navbar-menu'
micropost_feed = '.microposts'
micropost_field = 'Compose new micropost...'

RSpec.describe 'Create Micropost', type: :system, signed_in: true do
  # Updated Rspec.describe to 'Create Micropost' since test suite is for creating microposts
  let(:current_user) { create(:user, name: 'John Doe') }

  it 'allows user to create their first micropost' do
    within(navbar) do
      click_link 'Home'
    end

    expect(page).not_to have_selector(micropost_feed + " li")

    fill_in micropost_field, with: 'My first post!'
    click_button 'Post'

    within(micropost_feed) do
      expect(page).to have_selector('li', count: 1)
      expect(page).to have_content('My first post!')
    end
  end
end