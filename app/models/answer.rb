class Answer < ApplicationRecord
  belongs_to :question, dependent: :destroy
  validates :title, :body, :question_id, presence: true
end
