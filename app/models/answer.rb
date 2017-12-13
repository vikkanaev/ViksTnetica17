class Answer < ApplicationRecord
  include Votable

  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachmentable
  has_many :comments, as: :commentable, dependent: :destroy

  validates :body, presence: true
  validate :only_one_best_answer, if: :best?

  default_scope { order(best: :desc, created_at: :asc) }
  accepts_nested_attributes_for :attachments, reject_if: :all_blank

  def set_best
    Answer.transaction do
      question.answers.update_all(best: false)
      update!(best: true)
    end
  end

  def be_best?
    self.best?
  end

  def delete_if_legal(user)
    self.destroy if user.author_of?(self)
  end

  private

  def only_one_best_answer
    condition = question.answers.where(best: true)
    condition = condition.where.not(id: id) if persisted?
    errors.add(:base, 'There can be only one best answer!') if condition.present?
  end
end
