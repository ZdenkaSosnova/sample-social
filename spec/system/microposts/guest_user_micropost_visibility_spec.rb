require 'rails_helper'

# Collected locators in a common area for reusability and maintainability
micropost_content = "span.content"

RSpec.describe 'Guest user micropost visibility', type: :system do
  let!(:user) { create(:user) }
  let!(:micropost) { create(:micropost, user: user, content: 'Content') }

  it 'allows non-logged-in users to view microposts on user profile page' do
    created_micropost = "#micropost-#{micropost.id}"

    visit user_path(user)

    expect(page).to have_css(created_micropost)
    expect(page).to have_css(micropost_content, text: 'Content')
  end
end