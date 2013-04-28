class StaticController < ApplicationController
  def about
  end

  def home
    @posts = Post.published.limit(5)

  end

  def contact
  end
end
