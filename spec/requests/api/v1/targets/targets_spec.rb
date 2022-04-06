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
