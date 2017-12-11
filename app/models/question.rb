class Question < ApplicationRecord
  include Votable

  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachmentable
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, :body, presence: true
  accepts_nested_attributes_for :attachments, reject_if: :all_blank

  def delete_if_legal(user, question)
    question.destroy if user.author_of?(question)
  end
end
