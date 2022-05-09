require 'rails_helper'

describe 'POST api/v1/messages', type: :request do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:user3) { create(:user) }
  let(:target1) { create(:target, user_id: user.id) }
  let(:target2) do
    create(:target, user_id: user2.id, longitude: target1.longitude, latitude: target1.latitude,
                    topic_id: target1.topic_id, radius: 150)
  end
  let(:match) { create(:match, origin_target_id: target1.id, end_target_id: target2.id) }
  let(:conversation_id) { create(:conversation, match_id: match.id) }
  let!(:message) { build :message, conversation_id: conversation_id }
  subject do
    post api_v1_conversation_messages_path(conversation_id), params: message,
                                                             headers: auth_headers, as: :json
  end
  before do
    subject
  end
  context 'with valid params and valid auth' do
    it 'returns created status' do
      expect(response).to have_http_status(:created)
    end
    it 'checks if message is created' do
      expect(Message.find_by(title: message[:title])).to_not be_nil
    end
    it 'validates database count' do
      expect(Message.count).to eq(1)
    end
    it 'returns message params' do
      expect(response.body).to include('title', 'content', 'conversation_id')
    end
  end
  context 'with invalid params and valid auth' do
    let(:message) { build :message, conversation_id: conversation_id, title: nil }
    it 'returns unprocessable entity status' do
      expect(response).to have_http_status(:unprocessable_entity)
    end
    it 'checks if message is not created' do
      expect(Message.find_by(title: message[:title])).to be_nil
    end
    it 'validates database count' do
      expect(Message.count).to eq(0)
    end
  end
  context 'with valid params and invalid auth' do
    let(:message_params) { attributes_for(:message) }
    def subject
      post api_v1_conversation_messages_path(conversation_id), params: { message: message_params },
                                                               headers: nil, as: :json
    end
    before do
      subject
    end
    it 'returns unauthorized status' do
      expect(response).to have_http_status(:unauthorized)
    end
    it 'checks if message is not created' do
      expect(Message.find_by(title: message_params[:title])).to be_nil
    end
    it 'validates database count' do
      expect(Message.count).to eq(0)
    end
    it 'returns unathorized status if user is not a member of the conversation' do
      auth_headers2 = user3.create_new_auth_token
      post api_v1_conversation_messages_path(conversation_id), params: message,
                                                               headers: auth_headers2, as: :json
      expect(response).to have_http_status(:forbidden)
    end
  end
end
