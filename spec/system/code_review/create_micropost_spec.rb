require 'rails_helper'

RSpec.describe 'Create new micropost', type: :system, signed_in: true do
  let(:current_user) { create(:user, name: 'John Doe') }

  it 'creates public micropost' do
    click_navbar_item(name: "Home")

    create_micropost(content: "My first post!")
    expect_micropost_visible(content: "My first post!")
  end

  it 'creates private micropost' do
    click_navbar_item(name: "Home")

    create_micropost(content: "My first post!", visibility: "Followers only")
    expect_micropost_visible(content: "My first post!", followers_only: true)
  end
end
