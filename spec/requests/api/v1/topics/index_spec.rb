require 'rails_helper'

describe 'GET api/v1/topics', type: :request do
  let(:user) { create(:user) }
  let(:topics) { create_list :topic, 3 }
  subject { get api_v1_topics_path, headers: auth_headers, as: :json }
  before do
    subject
  end
  it 'returns status code 200' do
    expect(response).to have_http_status(:ok)
  end
  it 'returns all topics' do
    expect(topics.size).to eq(3)
  end
end
