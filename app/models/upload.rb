#awesome that you have an upload feature!

class Upload < ActiveRecord::Base
  belongs_to :user
  # nice use of comments to keep track of future improvements!

  # Validation not working ATM, will come back to this later if time
  # validates :name, presence: {message: "Hey, give me a name! How else will you know what you're cooking?"}

  mount_uploader :filepath, Uploader
end
