module NavbarHelper
  def click_navbar_item(name:)
    within('#navbar-menu') do
      click_link name
    end
  end
end