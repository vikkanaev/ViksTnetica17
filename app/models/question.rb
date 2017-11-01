class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :title, :body, presence: true

  def set_best_answer(answer)
    self.best_answer = answer.id
  end

  def unset_best_answer
    self.best_answer = nil
  end
end
