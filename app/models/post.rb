class Post < ActiveRecord::Base
  attr_accessible :body, :icon, :preview, :title, :published, :tag_list
  acts_as_taggable


  validates_presence_of :body, :title, :published

  scope :published, where(:published => true)
  scope :latest, order("published_at desc").limit(5)

end
