require 'spec_helper'

describe Post do
  subject { build(:post) }

  it { should be_valid }
  
  it "is valid with title body published" do
    expect(create(:post)).to be_valid
  end

  it "is invalid without a title" do
    expect(build(:post, title: nil)).to have(1).errors_on(:title)
  end

  it "has a user" do
  end
end
