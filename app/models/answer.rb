class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :attachments

  validates :body, presence: true
  validate :only_one_best_answer, if: :best?

  default_scope { order(best: :desc, created_at: :asc) }

  def set_best
    Answer.transaction do
      question.answers.update_all(best: false)
      update!(best: true)
    end
  end

  def be_best?
    self.best?
  end

  private

  def only_one_best_answer
    condition = question.answers.where(best: true)
    condition = condition.where.not(id: id) if persisted?
    errors.add(:base, 'There can be only one best answer!') if condition.present?
  end
end
