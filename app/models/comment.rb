class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true, touch: true

  validates :message, presence: true
end
