require 'rails_helper'

describe 'Profile API' do
  describe 'GET /me' do
    context 'unauthorized' do
      it 'returns 401 status if there is no access_token' do
        get '/api/v1/profiles/me', params: { format: :json }
        expect(response.status).to eq 401
      end

      it 'returns 401 status if access_token is invalid' do
        get '/api/v1/profiles/me', params: { format: :json, access_token: '1234' }
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      before { get '/api/v1/profiles/me', params: { format: :json, access_token: access_token.token } }

      it 'returns 200 status' do
        expect(response).to be_success
      end

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
  end

  describe 'GET /other_users_list' do
    context 'unauthorized' do
      it 'returns 401 status if there is no access_token' do
        get '/api/v1/profiles/other_users_list', params: { format: :json }
        expect(response.status).to eq 401
      end

      it 'returns 401 status if access_token is invalid' do
        get '/api/v1/profiles/other_users_list', params: { format: :json, access_token: '1234' }
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:me) { create(:user) }
      let!(:others) { create_list(:user, 2) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      before { get '/api/v1/profiles/other_users_list', params: { format: :json, access_token: access_token.token } }

      it 'returns 200 status' do
        expect(response).to be_success
      end

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
end
