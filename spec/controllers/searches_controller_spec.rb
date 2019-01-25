# NOTE: вернуть поиск

# require 'rails_helper'
#
# RSpec.describe SearchesController, type: :controller do
#   let(:search_request) { create(:question, user: user_author) }
#
#   describe 'GET #show' do
#     it 'get search everywhere with empty search_area' do
#       expect(Search).to receive(:search_result).with('ask', '')
#       post :show, params: { search_string: 'ask', search_area: '' }
#     end
#
#     it 'get search everywhere with search_area everyqhere' do
#       expect(Search).to receive(:search_result).with('ask', 'Everywhere')
#       post :show, params: { search_string: 'ask', search_area: 'Everywhere' }
#     end
#
#     %w[Questions Answers Comments Users].each do |attr|
#       it "gets search_area: #{attr}" do
#         expect(Search).to receive(:search_result).with('ask', attr)
#         post :show, params: { search_string: 'ask', search_area: attr }
#       end
#     end
#
#     %w[Everywhere Questions Answers Comments Users].each do |attr|
#       it 'redirect to search' do
#         post :show, params: { search_string: 'ask', search_area: attr }
#         expect(response).to render_template :show
#       end
#     end
#
#     it 'gets search_area: noname' do
#       expect(Search).to receive(:search_result).with('ask', 'Noname')
#       post :show, params: { search_string: 'ask', search_area: 'Noname' }
#     end
#   end
# end
