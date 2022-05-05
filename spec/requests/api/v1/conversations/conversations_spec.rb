require 'rails_helper'

describe 'GET /index', type: :request do
  let(:user) { create(:user) }
  let!(:conversations) { create_list :conversation, 3 }
  subject { get api_v1_conversations_path, headers: auth_headers, as: :json }
  before do
    subject
  end
  context 'with valid auth' do
    it 'returns ok status' do
      expect(response).to have_http_status(:ok)
    end
  end
end
