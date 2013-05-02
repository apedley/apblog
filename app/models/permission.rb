# class Permission < Struct.new(:user)
#   def allow?(controller, action)
#     return true if controller == "sessions"
#     return true if controller == "static"
#     return true if controller == "users" && action.in?(%w[new create])
#     return true if controller == "posts" && action.in?(%w[index show])
#     if user
#       #return true if controller == "users" && action.in(%w[edit update])
#       return true if user.admin?
#     end
#     false
#   end
# end

class Permission
  def initialize(user)
    allow :users, [:new, :create]
    allow :sessions, [:new, :create, :destroy]
    allow :posts, [:index, :show]
    allow :static, [:home, :about, :contact]
    if user
      allow :comments, [:new, :create]
      allow_all if user.admin?
    end
  end

  def allow_all
    @allow_all = true
  end

  def allow(controllers, actions, &block)
    @allowed_actions ||= {}
    Array(controllers).each do |controller|
      Array(actions).each do |action|
        @allowed_actions[[controller.to_s, action.to_s]] = block || true
      end
    end
  end

  def allow?(controller, action, resource = nil)
    allowed = @allow_all || @allowed_actions[[controller.to_s, action.to_s]]
    allowed && (allowed == true || resource && allowed.call(resource))
  end
end