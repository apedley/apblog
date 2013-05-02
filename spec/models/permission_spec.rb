require "spec_helper"

RSpec::Matchers.define :allow do |*args|
  match do |permission|
    permission.allow?(*args).should be_true
  end
end

describe Permission, focus: true do
  describe "as guest" do
    subject { Permission.new(nil) }
    it { should allow("posts", "index") }
    it { should allow("posts", "show") }
    it { should_not allow("posts", "new") }
    it { should_not allow("posts", "create") }
    it { should_not allow("posts", "edit") }
    it { should_not allow("posts", "update") }
    it { should_not allow("posts", "destroy") }

    it { should allow("sessions", "new") }
    it { should allow("sessions", "create") }
    it { should allow("sessions", "destroy") }

    it { should allow("users", "new") }
    it { should allow("users", "create") }
    it { should_not allow("users", "edit") }
    it { should_not allow("users", "update") }

    it { should allow("static", "home") }
    it { should allow("static", "about") }
    it { should allow("static", "contact") }
  end

  describe "as admin" do
    subject { Permission.new(build(:user, admin: true)) }
    it { should allow("anything", "here") }
  end

  describe "as member" do
    let(:user) { create(:user, admin: false) }
    let(:other_user) { create(:user, admin:false) }
    subject { Permission.new(user) }

    it { should allow("posts", "index") }
    it { should allow("posts", "show") }
    it { should_not allow("posts", "new") }
    it { should_not allow("posts", "create") }
    it { should_not allow("posts", "edit") }
    it { should_not allow("posts", "update") }
    it { should_not allow("posts", "destroy") }

    it { should allow("sessions", "new") }
    it { should allow("sessions", "create") }
    it { should allow("sessions", "destroy") }

    it { should allow("users", "new") }
    it { should allow("users", "create") }
    # it { should allow("users", "edit", user) }
    # it { should allow("users", "update", user) }
    # it { should_not allow("users", "edit", other_user) }
    # it { should_not allow("users", "update", other_user) }

    it { should allow("static", "home") }
    it { should allow("static", "about") }
    it { should allow("static", "contact") }
  end
end
