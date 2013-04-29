require 'spec_helper'
feature 'display posts' do

  def login
    user = FactoryGirl.create(:user)
    visit login_path
    within("div#big_login") do
      fill_in "Name", :with => user.name
      fill_in "Password", :with => user.password
      click_button "Login"
    end
  end

  background do
    post = create(:post)
    post2 = build(:post, title: "test title")
  end

  scenario "goes to post index" do
    visit "/posts"
    expect(page).to have_selector('div.post')
  end

  scenario "go to post page to view one post" do
    post3 = create(:post, title: 'p 3 333', body: 'ofijwpeoij a3')
    visit "/posts/#{post3.id}"
    
    expect(page).to have_selector('div.post', :count => 1)
  end

  scenario "edits a post and shows the update" do
    post = create(:post, title: 'My Title', body: 'My Body', id: 32)
    post2 = create(:post)
    post4 = create(:post, title: 'p 44', body: 'ofijwpeoij a4')

    visit root_path

    expect(page).to_not have_selector('.links')
    login
    expect(page).to have_selector('.links')
    first(:link, post.title).click
    click_link 'Edit'
    fill_in 'Title', with: post2.title
    fill_in 'Body', with: post2.body
    click_button 'Save'
    expect(page).to have_content(post2.title)
  end

  scenario "deletes a post" do
    post = create(:post)
    login
    visit root_path
    first(:link, post.title).click
    expect { click_link 'Destroy' }.to change(Post, :count).by(-1)
  end

end