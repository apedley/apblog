require "spec_helper"

feature "Static pages" do
  scenario "User goes to about" do
    visit "/static/about"
    expect(page).to have_title("About | Andrew Pedley")
    #expect(page).to have_selector('title', :text => 'About | Andrew Pedley')
  end
end
