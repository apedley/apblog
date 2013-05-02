require 'spec_helper'

feature 'display posts' do

  def login
    user = create(:user)
    visit login_path

    within("div#big_login") do
      fill_in "Name", :with => user.name
      fill_in "Password", :with => user.password
      click_button "Login"
    end
  end

  background do
    user = create(:user)
    post = create(:post, user: user)
  end

  scenario "goes to post index" do
    visit "/posts"
    login
    expect(page).to have_selector('div.post')
  end

  scenario "go to post page to view one post" do
    post3 = create(:post, title: 'p 3 333', body: 'ofijwpeoij a3')
    visit "/posts/#{post3.id}"
    
    expect(page).to have_selector('div.post', :count => 1)
  end

  scenario "edits a post and shows the update" do
    visit root_path
    expect(page).to_not have_link('edit')

    user = create(:user)
    visit login_path

    within("div#big_login") do
      fill_in "Name", :with => user.name
      fill_in "Password", :with => user.password
      click_button "Login"
    end
    post = create(:post, user: user)
    post2 = create(:post, user:user)

    visit post_path(post.id)
    expect(page).to have_link('Edit')
    click_link 'Edit'
    fill_in 'Title', with: post2.title
    fill_in 'Body', with: post2.body
    click_button 'Save'
    expect(page).to have_content(post2.title)
  end

  scenario "deletes a post" do
    visit root_path
    expect(page).to_not have_link('Destroy')

    user = create(:user)
    visit login_path

    within("div#big_login") do
      fill_in "Name", :with => user.name
      fill_in "Password", :with => user.password
      click_button "Login"
    end
    post = create(:post, user: user)

    visit post_path(post.id)
    expect { click_link 'Destroy' }.to change(Post, :count).by(-1)
  end

end