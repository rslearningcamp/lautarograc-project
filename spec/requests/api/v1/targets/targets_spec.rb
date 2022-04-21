require 'rails_helper'

describe 'POST /create', type: :request do
  let(:user) { create(:user) }
  let(:target) { create(:target) }
  context 'with valid params and valid auth' do
    it 'returns created status' do
      attrs = attributes_for(:target)
      post '/api/v1/targets', params: { target: attrs },
                              headers: auth_headers, as: :json
      expect(response).to have_http_status(:created)
    end
  end
  context 'with invalid params and valid auth' do
    it 'returns unprocessable entity status' do
      attrs = attributes_for(:target, latitude: nil)
      post '/api/v1/targets', params: { target: attrs },
                              headers: auth_headers, as: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
  context 'with valid params and invalid auth' do
    it 'returns unauthorized status' do
      attrs = attributes_for(:target)
      post '/api/v1/targets', params: { target: attrs },
                              headers: nil, as: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end
  context 'with invalid params and invalid auth' do
    it 'returns unauthorized status' do
      attrs = attributes_for(:target, latitude: nil)
      post '/api/v1/targets', params: { target: attrs },
                              headers: nil, as: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
describe 'GET /index', type: :request do
  let(:user) { create(:user) }
  let(:target) { create_list(:target, 5, user_id: user.id) }
  context 'with valid auth' do
    it 'returns ok status' do
      get '/api/v1/targets', headers: auth_headers, as: :json
      expect(response).to have_http_status(:ok)
    end
  end
  context 'with invalid auth' do
    it 'returns unauthorized status' do
      get '/api/v1/targets', headers: nil, as: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end
end

describe 'DELETE /destroy', type: :request do
  let(:user) { create(:user) }
  let(:target) { create(:target, user_id: user.id) }
  context 'with valid auth' do
    it 'returns no content status' do
      delete "/api/v1/targets/#{target.id}", headers: auth_headers, as: :json
      expect(response).to have_http_status(:no_content)
    end
  end
  context 'with invalid auth' do
    it 'returns unauthorized status' do
      delete "/api/v1/targets/#{target.id}", headers: nil, as: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
