require 'rails_helper'

# Collected locators in a common area for reusability and maintainability
navbar = '#navbar-menu'
alert_success = '.alert.alert-success'
alert_info = '.alert.alert-info'
follow_form = '#follow_form'


RSpec.describe 'Test1', type: :system, signed_in: true do
  let(:current_user) { create(:user, :admin, name: 'John Doe') }
  let(:other_user) { create(:user) }

  context "when the poll was created by other user" do
    let!(:poll) { create(:poll, user: other_user) }
    let!(:option) { poll.poll_options.first }

    it 'disallows current user to vote on poll of not followed user' do
      # Tests the scenario when current user is not following the user that created the poll
      # Steps:
      # 1. Generate a poll using other user
      # 2. Login as current user
      # 3. Navigate to polls page and verify that poll is created
      # 4. Open the created poll
      # 5. Validate that the Info message is present showing that user needs to be a follower to vote on poll

      created_poll = "(//a[@href='/polls/#{poll.id}'])[1]"

      within(navbar) do
        click_link 'Polls'
      end

      expect(page).to have_xpath(created_poll)
      find(:xpath, created_poll).click

      expect(page).to have_css(alert_info, text: 'You need to follow User to vote on this poll.')
    end

    it 'allows current user to vote on poll of followed user' do
      # Tests the scenario when current user is following the user that created the poll
      # Split this test case into a separate scenario to avoid excessive validations in a single test case
      # Steps:
      # 1. Generate a poll using other user
      # 2. Login as current user
      # 3. Current user opens the profile of the other user
      # 4. Click follow on the profile page of the other user
      # 5. Navigate to polls page and verify that poll is created
      # 6. Open the created poll
      # 7. Validate that the Success message is present showing that vost is posted on poll

      created_poll = "(//a[@href='/polls/#{poll.id}'])[1]"

      visit users_path
      click_link 'User'

      within(follow_form) do
        click_button 'Follow'
      end

      within(navbar) do
        click_link 'Polls'
      end

      expect(page).to have_xpath(created_poll)
      find(:xpath, created_poll).click

      click_on option.option_text
      expect(page).to have_css(alert_success, text: 'Vote recorded successfully!')
    end

  end
end