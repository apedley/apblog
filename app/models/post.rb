class Post < ActiveRecord::Base
  attr_accessible :body, :icon, :preview, :title, :published
  scope :published, where(:published => true)
end
