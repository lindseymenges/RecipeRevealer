class Upload < ActiveRecord::Base
  belongs_to :user

  # Validation not working ATM, will come back to this later if time
  # validates :name, presence: {message: "Hey, give me a name! How else will you know what you're cooking?"}

  mount_uploader :filepath, Uploader
end
