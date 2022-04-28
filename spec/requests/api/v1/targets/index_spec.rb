require 'rails_helper'

describe 'GET api/v1/targets', type: :request do
  let(:user) { create(:user) }
  let(:target) { create_list :target, 3 }
  subject { get api_v1_targets_path, headers: auth_headers, as: :json }
  before do
    subject
  end
  context 'with valid auth' do
    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
    it 'returns all targets' do
      expect(target.size).to eq(3)
    end
  end
  context 'with invalid auth' do
    it 'returns status code 401' do
      get api_v1_targets_path, headers: nil, as: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
