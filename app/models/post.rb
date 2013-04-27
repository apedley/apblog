class Post < ActiveRecord::Base
  attr_accessible :body, :icon, :preview, :title
end
