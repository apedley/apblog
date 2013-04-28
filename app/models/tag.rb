class Tag < ActiveRecord::Base
  attr_accessible :name

  has_many :taggings
  has_many :posts, through: :taggings

  def self.used
    Tag.all.select { |t| t.taggings.count > 0 }.sort { |t, v| t.taggings.count <=> v.taggings.count }.reverse
  end
end
