class Question < ApplicationRecord
  include Votable

  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachmentable
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  validates :title, :body, presence: true
  accepts_nested_attributes_for :attachments, reject_if: :all_blank

  after_create :subscribe_author

  def find_subscription(user)
    Subscription.where(user: user).first
  end

  private

  def subscribe_author
    subscriptions.create(user: user)
  end
end
