class StaticController < ApplicationController
  def about
  end

  def home
    @posts = Post.latest

  end
end
