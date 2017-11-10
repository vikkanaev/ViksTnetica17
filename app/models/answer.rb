class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  validates :body, presence: true
  validate :only_one_best_answer #, on: self.best_changed?

  default_scope { order(best: :desc, created_at: :asc) }

  def set_best
    Answer.transaction do
      question.answers.update_all(best: false)
      update!(best: true)
    end
  end

  private

  def only_one_best_answer
    errors.add(:base, 'There can be only one best answer!') if self.question.answers.where(best: true).count > 1
  end
end
