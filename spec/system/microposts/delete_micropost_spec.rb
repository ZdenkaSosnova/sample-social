require 'rails_helper'

# Collected locators in a common area for reusability and maintainability
alert_success = '.alert.alert-success'

RSpec.describe 'Deleting microposts', type: :system, signed_in: true do
  let(:current_user) { create(:user, :admin, name: 'John Doe') }

  context "when the micropost was created by admin user" do
    let!(:admin_user) { create(:user, :admin, name: "Jane Admin") }
    let!(:micropost) { create(:micropost, user: admin_user) }

    it 'admin users can delete other admins micropost' do
      created_micropost = "#micropost-#{micropost.id}"

      visit user_path(admin_user)

      expect(page).to have_css(created_micropost)

      within(created_micropost) do
        accept_confirm do
          click_link 'delete'
        end
      end

      expect(page).to have_css(alert_success, text: 'Micropost deleted')
      expect(page).not_to have_css(created_micropost)
    end
  end
end