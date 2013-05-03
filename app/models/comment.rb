class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  has_many :comments, :as => :commentable, :dependent => :destroy
  belongs_to :user
  attr_accessible :approved, :body, :post, :user

  validates_presence_of :body, :user_id

  def post
    return @post if defined?(@post)
    @post = commentable.is_a?(Post) ? commentable : commentable.post
  end

  def self.approval_queue
    where(:approved => false)
  end
end
