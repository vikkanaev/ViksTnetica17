class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  validates :body, presence: true

  def is_best?
    # true if answer is best_answer
    self.question.best_answer == self.id
  end
end
