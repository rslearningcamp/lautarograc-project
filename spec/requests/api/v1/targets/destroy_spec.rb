require 'rails_helper'

describe 'DELETE /destroy', type: :request do
  let(:user) { create(:user) }
  let(:target) { create(:target, user_id: user.id) }
  let(:user2) { create(:user) }
  context 'with valid auth' do
    subject { delete "/api/v1/targets/#{target.id}", headers: auth_headers, as: :json }
    before do
      subject
    end
    it 'returns no content status' do
      expect(response).to have_http_status(:no_content)
    end
    it 'checks if target is deleted' do
      expect(Target.find_by(id: target.id)).to be_nil
    end
    it 'validates database count' do
      expect(Target.count).to eq(0)
    end
  end
  context 'with invalid auth' do
    it 'if not logged in returns unauthorized status' do
      delete "/api/v1/targets/#{target.id}", headers: nil, as: :json
      expect(response).to have_http_status(:unauthorized)
    end
    it 'if logged in but not owner returns forbidden status' do
      auth_headers2 = user2.create_new_auth_token
      delete "/api/v1/targets/#{target.id}", headers: auth_headers2, as: :json
      expect(response).to have_http_status(:forbidden)
    end
  end
end
