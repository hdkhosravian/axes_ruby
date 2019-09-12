class Image < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  has_attached_file :picture, styles: {large: "800x800>", medium: "400x400>", small: "120x120>"}
  validates_attachment_content_type :picture, content_type: %w(image/jpeg image/jpg image/png)
end