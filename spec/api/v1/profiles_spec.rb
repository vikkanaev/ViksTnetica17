require 'rails_helper'

describe 'Profile API' do
  describe 'GET /me' do
    it_behaves_like "API Authenticable"

    context 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      before { get '/api/v1/profiles/me', params: { format: :json, access_token: access_token.token } }

      it_behaves_like "API be_success"

      %w(id email created_at updated_at admin).each do |attr|
        it "contains #{attr}" do
          expect(response.body).to be_json_eql(me.send(attr.to_sym).to_json).at_path(attr)
        end
      end

      %w(password encrypted_password).each do |attr|
        it "does not contain #{attr}" do
          expect(response.body).to_not have_json_path(attr)
        end
      end
    end

    def do_request(options = {})
      get '/api/v1/profiles/me', params: { format: :json }.merge(options)
    end
  end

  describe 'GET /other_users_list' do
    it_behaves_like "API Authenticable"

    context 'authorized' do
      let(:me) { create(:user) }
      let!(:others) { create_list(:user, 2) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      before { get '/api/v1/profiles/other_users_list', params: { format: :json, access_token: access_token.token } }

      it_behaves_like "API be_success"

      context 'for other_user_1' do
        %w(id email created_at updated_at admin).each do |attr|
          it "contains #{attr}" do
            expect(response.body).to be_json_eql(others.first.send(attr.to_sym).to_json).at_path("0/#{attr}")
          end
        end

        %w(password encrypted_password).each do |attr|
          it "does not contain #{attr}" do
            expect(response.body).to_not have_json_path(attr)
          end
        end
      end

      context 'for other_user_2' do
        %w(id email created_at updated_at admin).each do |attr|
          it "contains #{attr}" do
            expect(response.body).to be_json_eql(others.last.send(attr.to_sym).to_json).at_path("1/#{attr}")
          end
        end

        %w(password encrypted_password).each do |attr|
          it "does not contain #{attr}" do
            expect(response.body).to_not have_json_path(attr)
          end
        end
      end

      it 'returns list of all users expect me' do
        expect(response.body).to_not be_json_eql(me.to_json)
      end
    end
  end

  def do_request(options = {})
    get '/api/v1/profiles/other_users_list', params: { format: :json }.merge(options)
  end
end
