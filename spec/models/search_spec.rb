# NOTE: вернуть поиск

# require 'rails_helper'
#
# RSpec.describe Search, type: :model do
#   describe 'method search_result' do
#     %w[Noname Everywhere ''].each do |attr|
#       it "gets condition #{attr}" do
#         expect(ThinkingSphinx).to receive(:search).with("ask", {:star=>true})
#         Search.search_result('ask', attr)
#       end
#     end
#     %w[Questions Answers Comments Users].each do |attr|
#       it "gets condition: #{attr}" do
#         expect(attr.singularize.classify.constantize).to receive(:search).with("ask", {:star=>true})
#         Search.search_result('ask', attr)
#       end
#     end
#   end
# end
