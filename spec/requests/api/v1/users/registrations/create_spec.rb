require 'rails_helper'

describe 'POST api/v1/users/', type: :request do
  subject { post api_user_registration_path, params: params, as: :json }

  let(:failed_response) { 422 }

  describe 'POST create' do
    let(:email)                 { 'test@test.com' }
    let(:password)              { '12345678' }
    let(:password_confirmation) { '12345678' }

    let(:params) do
      {
        user: {
          email: email,
          password: password,
          password_confirmation: password_confirmation
        }
      }
    end

    it 'returns a successful response' do
      subject

      expect(response).to be_successful
    end

    it 'creates the user' do
      expect {
        subject
      }.to change(User, :count).by(1)
    end

    it 'returns the user' do
      subject

      expect(json[:user][:email]).to eq(email)
      expect(json[:user][:provider]).to eq('email')
      expect(json[:user][:uid]).to eq(email)
    end

    context 'when passwords dont match' do
      let(:password_confirmation) { '12345' }

      it 'does not return a successful response' do
        subject

        expect(response.status).to eq(failed_response)
      end

      it 'does not create new user' do
        subject

        expect {
          subject
        }.not_to change(User, :count)
      end
    end
  end
end
