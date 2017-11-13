class Attachment < ApplicationRecord
  belongs_to :answer

  mount_uploader :file, FileUploader
end
