require 'rails_helper'

RSpec.describe 'Micropost visibility', type: :system, signed_in: true do
  let(:current_user) { create(:user, name: 'John Doe') }
  let(:user) { create(:user) }
  let!(:micropost) { create(:micropost, user: user, content: 'Content') }

  it 'user can take a look at other user feed' do
    visit user_path(user)

    expect(page).not_to have_css("#micropost-#{micropost.id}")
    expect(page).not_to have_css("span.content", text: 'Content')
  end
end