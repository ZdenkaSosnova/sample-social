require 'rails_helper'

RSpec.describe 'Deleting microposts', type: :system, signed_in: true do
  let(:current_user) { create(:user, :admin, name: 'John Doe') }

  context "when the micropost was created by admin user" do
    let!(:admin_user) { create(:user, :admin, name: "Jane Admin") }
    let!(:micropost) { create(:micropost, user: admin_user) }

    it 'admin can delete other admin micropost from profile page' do
      visit user_path(admin_user) # /users/:id
      expect_micropost_visible(content: "Lorem ipsum", followers_only: true)

      delete_micropost(micropost:)
      expect_micropost_not_visible(micropost:)
    end

    it 'admin can delete other admin micropost from home feed' do
      click_navbar_item(name: "Home") # /
      expect_micropost_visible(content: "Lorem ipsum", followers_only: true)

      delete_micropost(micropost:)
      expect_micropost_not_visible(micropost:)
    end
  end
end