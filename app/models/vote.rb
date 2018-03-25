class Vote < ApplicationRecord
  belongs_to :votable, polymorphic: true, touch: true
  belongs_to :user

  validates :score, presence: true, inclusion: { in: (-1..1) }
end
