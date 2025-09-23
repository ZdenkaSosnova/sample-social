require 'rails_helper'

RSpec.describe 'User Following', type: :system, signed_in: true do
  let!(:other_user) { create(:user) }
  let(:current_user) { create(:user, :admin, name: 'John Doe') }

  it 'allows user to follow another user from their profile page' do
    sleep 2
    visit users_path

    within('ul.users') do
      first('li a').click
    end

    # Check initial followers count
    expect(find('#followers.stat')).to have_text('0')

    within('#follow_form') do
      click_button 'Follow'
    end

    # Check that followers count increased
    expect(find('#followers.stat')).to have_text('1')
  end
end