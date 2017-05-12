class ImageAttachment < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true

  mount_uploader :photo,ImageUploader

end
