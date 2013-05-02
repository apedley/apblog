class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :password_confirmation, :admin

	has_secure_password

	validates_presence_of :email, :name
	validates_uniqueness_of :email, :name
	validates_presence_of :password_digest, :on => :create
	
	has_many :posts

	before_create { generate_token(:auth_token) }


  def generate_token(column)
  	begin
  		self[column] = SecureRandom.urlsafe_base64
  	end while User.exists?(column => self[column])
  end
end
