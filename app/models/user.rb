class User < ActiveRecord::Base
  has_many :recipes
  validates :username, presence: {message: "Everyone needs a username! How else is a little ol' computer like me going to know who you are?"}
  validates :username, uniqueness: {message: "Sorry, that name has been taken! But you're so lovely - I'm sure you have a lot of great ideas for usernames. Give it another shot!"}
  validates :password, presence: {message: "You definitely want a password, otherwise I might try to steal your recipes. Just kidding! But really, you'll want a password."}
  
  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end