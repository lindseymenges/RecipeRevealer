class Upload < ActiveRecord::Base
  belongs_to :user

  mount_uploader :filepath, Uploader
  
  validates :name, presence: {message: "Hey, give me a name! How else will you know what you're cooking?"}
end
