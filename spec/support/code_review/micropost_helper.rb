module MicropostHelper
  def create_micropost(content:, visibility: "Everyone")
    fill_in 'Compose new micropost...', with: content
    select visibility, from: 'micropost_visibility'
    click_button 'Post'
  end

  def expect_micropost_visible(content:, followers_only: false)
    within('.microposts') do
      micropost = find('li', text: content)
      within(micropost) do
        expect(page).to have_css('span.content', text: content)
        expect(page).to have_css('span.badge.badge-warning', text: 'Followers only') if followers_only
      end
    end
  end

  def expect_micropost_not_visible(micropost:)
    expect(page).not_to have_css("#micropost-#{micropost.id}")
  end

  def delete_micropost(micropost:)
    within("#micropost-#{micropost.id}") do
      accept_confirm do
        click_link 'delete'
      end
    end
    expect(page).to have_css('.alert.alert-success', text: 'Micropost deleted')
  end
end