require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  describe 'public model methods' do
    let!(:user_author) { create(:user) }
    let!(:user_not_author) { create(:user) }
    let!(:question) { create(:question, user: user_author) }

    context 'Return True if user is author' do
      it { expect(user_author.author_of?(question)).to be(true) }
    end
    context 'Return False if user is not author' do
      it { expect(user_not_author.author_of?(question)).to be(false) }
    end
  end
end
