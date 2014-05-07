class Uploader < CarrierWave::Uploader::Base
  storage :fog
end