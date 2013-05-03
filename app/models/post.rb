class Post < ActiveRecord::Base
  attr_accessible :body, :icon, :title, :published, :tag_list, :rendered_body, :subtitle, :preview
  validates_presence_of :body, :title, :published, :user_id
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :comments, :as => :commentable
  belongs_to :user

  before_save :render_body

  searchable do
    # text :title, :boost => 2.0
    text :body, :stored => true

    string :title, :stored => true
    boolean :published
    time :published_at

  end

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

  def self.published()
    where(:published => true).order("published_at desc")
  end

  def self.recent
    where(:published => true).limit(5).order("published_at desc")
  end

  private

  def render_body
    renderer = HTMLwithPygments.new(:hard_wrap => true)
    options = {
      :fenced_code_blocks => true,
      :no_intra_emphasis => true,
      :autolink => true,
      :strikethrough => true,
      :lax_html_blocks => true,
      :tables => true,
      :superscript => true
    }
    self.rendered_body = Redcarpet::Markdown.new(renderer, options).render(self.body)
  end
end


class HTMLwithPygments < Redcarpet::Render::HTML
  def block_code(code, language)
    Pygments.highlight(code, :lexer => language)
  end
end


