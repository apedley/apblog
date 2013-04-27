require 'spec_helper'

describe "posts/show" do
  before(:each) do
    @post = assign(:post, stub_model(Post,
      :title => "Title",
      :preview => "Preview",
      :body => "MyText",
      :icon => "Icon"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Preview/)
    rendered.should match(/MyText/)
    rendered.should match(/Icon/)
  end
end
