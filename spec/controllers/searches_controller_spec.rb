require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  let(:search_request) { create(:question, user: user_author) }

  describe 'GET #show' do
    before { post :show } # , params: { q: question } }

    it 'assigns the search_request to variable'

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end
end
