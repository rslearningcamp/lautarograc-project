require 'rails_helper'

describe 'POST api/v1/admin_users/sign_in', type: :request do
  let(:password) { 'password' }
  let(:admin_user) { create(:admin_user, password: password) }

  context 'with correct params' do
    before do
      params = {
        admin_user:
          {
            email: admin_user.email,
            password: password
          }
      }
      post new_api_admin_user_session_path, params: params, as: :json
    end

    it 'returns a succesful response' do
      expect(response).to have_http_status(:success)
    end

    it 'returns the admin user' do
      expect(json[:admin_user]).to include_json(
        id: admin_user.id,
        email: admin_user.email,
        name: admin_user.name
      )
    end

    it 'returns a valid client and access token' do
      token = response.header['access-token']
      client = response.header['client']
      expect(admin_user.reload.valid_token?(token, client)).to be_truthy
    end
  end

  context 'with incorrect params' do
    it 'returns error' do
      params = {
        admin_user:
          {
            email: admin_user.email,
            password: 'incorrect_password'
          }
      }
      post new_api_admin_user_session_path, params: params, as: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
