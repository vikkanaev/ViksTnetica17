class User < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :answer, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def author_of?(object)
    object.user_id == id
  end
end
