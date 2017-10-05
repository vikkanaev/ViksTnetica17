class Answer < ApplicationRecord
  belongs_to :question, dependent: :destroy
  validates :title, :body, presence: true
end
