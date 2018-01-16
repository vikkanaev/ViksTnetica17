require 'rails_helper'

RSpec.describe Authorization, type: :model do
  describe 'self.generate' do
    let(:params) { { provider: 'facebook', uid: '123', email: 'test@foobar.com' } }

    it 'create authorization if user with the email exist' do
      create(:user, email: params[:email])
      expect(Authorization.generate(params)).to be_a Authorization
    end

    it 'create authorization if user with the email does not exist' do
      expect(Authorization.generate(params)).to be_a Authorization
    end

    it 'return existing authorization if this already exist' do
      user = create(:user, email: params[:email])
      authorization = create(:authorization, provider: params[:provider], uid: params[:uid], user: user)
      expect(Authorization.generate(params)).to eq authorization
    end
  end
end
