# Moved file into separate directory
require 'rails_helper'

# Collected locators in a common area for reusability and maintainability
follow_form = '#follow_form'
followers_count = '#followers.stat'

RSpec.describe 'User Following', type: :system, signed_in: true do
  let!(:other_user) { create(:user) }
  let(:current_user) { create(:user, :admin, name: 'John Doe') }

  it 'allows user to follow another user from their profile page' do
    sleep 2
    visit users_path

    # Updated step to click specifically on other user to avoid case where own user is on the top on the list
    click_link 'User'

    # Check initial followers count
    expect(find(followers_count)).to have_text('0')

    within(follow_form) do
      click_button 'Follow'
    end

    # Check that followers count increased
    expect(find(followers_count)).to have_text('1')
  end
end