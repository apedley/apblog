require 'spec_helper'

feature 'maintaining posts as admin' do
  def login
    user = FactoryGirl.create(:user, admin: true)
    visit login_path
    within("div#big_login") do
      fill_in "Name", :with => user.name
      fill_in "Password", :with => user.password
      click_button "Login"
    end
  end

  scenario "logging in with correct credentials" do
    login
    page.should have_content("successfully")
  end

  scenario "logging out" do
    login
    click_link "Logout"
    expect(page).to have_content('logged out')
  end

  scenario "creating post without logging in" do
    visit "/posts/new"
    expect(page).to have_content('Not authorized')
  end

  scenario "creating post after logging in" do
    login
    visit "/posts/new"
    expect(page).to have_button("Create")
  end
end