require 'rails_helper'

RSpec.describe 'Guest user micropost visibility', type: :system do
  let(:user) { create(:user) }
  let!(:micropost) { create(:micropost, user: user, content: 'Content') }

  it 'non-logged-in user viewing microposts on other user profile' do
    visit user_path(user)

    expect(page).to have_css("#micropost-#{micropost.id}")
    expect(page).to have_css("span.content", text: 'Content')
  end
end