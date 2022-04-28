require 'rails_helper'

describe 'GET /index', type: :request do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:target) { create(:target, user: user) }
  let(:target2) { create(:target, user: user2) }
  let(:match) { create(:match, origin_target: target, end_target: target2) }
  let(:match2) { create(:match, origin_target: target2, end_target: target) }
  let(:conversation) { create(:conversation, match: match) }
  let(:conversation2) { create(:conversation, match: match2) }

  context 'with valid auth' do
    it 'returns ok status' do
      get '/api/v1/conversations', headers: auth_headers, as: :json
      expect(response).to have_http_status(:ok)
    end
  end
end
