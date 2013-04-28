class StaticController < ApplicationController
  def about
  end

  def home
    @posts = Post.published

  end

  def contact
  end
end
