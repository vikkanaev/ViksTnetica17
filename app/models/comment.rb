class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true

  validates :message, presence: true
end
