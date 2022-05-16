require 'rails_helper'

describe 'GET api/v1/messages', type: :request do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:user3) { create(:user) }
  let(:target1) { create(:target, user_id: user.id) }
  let(:target2) do
    create(:target, user_id: user2.id, longitude: target1.longitude, latitude: target1.latitude,
                    topic_id: target1.topic_id, radius: 150)
  end
  let(:match) { create(:match, origin_target_id: target1.id, end_target_id: target2.id) }
  let(:conversation) { create(:conversation, match_id: match.id) }
  let!(:message) { create_list :message, 2, conversation_id: conversation.id }
  subject do
    get api_v1_conversation_messages_path(conversation.id, page: 1),
        headers: auth_headers, as: :json
  end
  before do
    subject
  end
  context 'with valid params and valid auth' do
    it 'returns success status' do
      expect(response).to have_http_status(:success)
    end
    it 'checks if message is created' do
      expect(response.body).to include(message[0].title)
    end
    it 'returns correct meta' do
      expect(json['meta']['total_messages_count']).to eq(2)
      expect(json['meta']['current_page']).to eq(1)
      expect(json['meta']['total_pages']).to eq(1)
      expect(json['meta']['next_page']).to be_nil
      expect(json['meta']['prev_page']).to be_nil
    end
  end
  context 'with invalid params and valid auth' do
    it 'returns empty page' do
      get api_v1_conversation_messages_path(conversation.id, page: 65, per_page: 2),
          headers: auth_headers, as: :json
      expect(response.body).to include('[]')
    end
  end
  context 'with valid params and invalid auth' do
    it 'returns unauthorized status' do
      get api_v1_conversation_messages_path(conversation.id, page: 1),
          headers: {}, as: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
