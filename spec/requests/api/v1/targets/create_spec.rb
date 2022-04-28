require 'rails_helper'

describe 'POST api/v1/targets', type: :request do
  let(:user) { create(:user) }
  subject do
    post api_v1_targets_path, params: { target: target_params },
                              headers: auth_headers, as: :json
  end
  before do
    subject
  end
  context 'with valid params and valid auth' do
    let(:target_params) { attributes_for(:target) }
    it 'returns created status' do
      expect(response).to have_http_status(:created)
    end
    it 'checks if target is created' do
      expect(Target.find_by(latitude: target_params[:latitude])).to_not be_nil
    end
    it 'validates database count' do
      expect(Target.count).to eq(1)
    end
    it 'returns target params' do
      expect(response.body).to include('latitude', 'longitude')
    end
    it 'returns validation error if exceeds target_length' do
      (1..4).each do |i|
        attrs = attributes_for(:target, title: "title#{i}")
        post '/api/v1/targets', params: { target: attrs },
                                headers: auth_headers, as: :json
      end
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
  context 'with invalid params and valid auth' do
    let(:target_params) { attributes_for(:target, latitude: nil) }
    it 'returns unprocessable entity status' do
      expect(response).to have_http_status(:unprocessable_entity)
    end
    it 'checks if target is not created' do
      expect(Target.find_by(latitude: target_params[:latitude])).to be_nil
    end
    it 'validates database count' do
      expect(Target.count).to eq(0)
    end
  end
  context 'with valid params and invalid auth' do
    let(:target_params) { attributes_for(:target) }
    def subject
      post api_v1_targets_path, params: { target: target_params },
                                headers: nil, as: :json
    end
    before do
      subject
    end
    it 'returns unauthorized status' do
      expect(response).to have_http_status(:unauthorized)
    end
    it 'checks if target is not created' do
      expect(Target.find_by(latitude: target_params[:latitude])).to be_nil
    end
    it 'validates database count' do
      expect(Target.count).to eq(0)
    end
  end
  context 'with invalid params and invalid auth' do
    let(:target_params) { attributes_for(:target, latitude: nil) }
    def subject
      post api_v1_targets_path, params: { target: target_params },
                                headers: nil, as: :json
    end
    before do
      subject
    end
    it 'returns unauthorized status' do
      expect(response).to have_http_status(:unauthorized)
    end
    it 'checks if target is not created' do
      expect(Target.find_by(latitude: target_params[:latitude])).to be_nil
    end
    it 'validates database count' do
      expect(Target.count).to eq(0)
    end
  end
end
