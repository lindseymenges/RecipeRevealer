class Upload < ActiveRecord::Base
  belongs_to :user
  
  # validates :name, presence: {message: "Hey, give me a name! How else will you know what you're cooking?"}

  mount_uploader :filepath, Uploader
end
