class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :title, :body, presence: true
#  validate :only_one_best_answer
#
#  private
#
#  def only_one_best_answer
#    errors.add(:base, 'There can be only one best answer!') if self.answers.where(best: true).count > 1
#  end
end
