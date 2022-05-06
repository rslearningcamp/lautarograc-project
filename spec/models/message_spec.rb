# == Schema Information
#
# Table name: messages
#
#  id              :bigint           not null, primary key
#  content         :text
#  title           :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  conversation_id :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_messages_on_conversation_id  (conversation_id)
#  index_messages_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (conversation_id => conversations.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Message, type: :model do
  subject { build(:message) }

  describe 'factory' do
    it { is_expected.to be_valid }
  end

  describe 'database' do
    it { is_expected.to have_db_column(:title).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:content).of_type(:text) }
    it {
      is_expected.to have_db_column(:conversation_id).of_type(:integer).with_options(null: false)
    }
  end
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(255) }
  end
  describe 'associations' do
    it { is_expected.to belong_to(:conversation) }
  end
end
