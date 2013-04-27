class Post < ActiveRecord::Base
  attr_accessible :body, :icon, :preview, :title, :published, :tag_list, :body_html
  has_many :taggings
  has_many :tags, through: :taggings


  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end
  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").joins(:taggings).group("taggings.tag_id")
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end


  validates_presence_of :body, :title, :published

  scope :published, where(:published => true)
  scope :latest, order("published_at desc").limit(5)



end


