# == Schema Information
#
# Table name: matches
#
#  id               :bigint           not null, primary key
#  conversation_id  :bigint
#  end_target_id    :bigint           not null
#  origin_target_id :bigint           not null
#
# Indexes
#
#  index_matches_on_conversation_id   (conversation_id)
#  index_matches_on_end_target_id     (end_target_id)
#  index_matches_on_origin_target_id  (origin_target_id)
#
# Foreign Keys
#
#  fk_rails_...  (conversation_id => conversations.id)
#  fk_rails_...  (end_target_id => targets.id)
#  fk_rails_...  (origin_target_id => targets.id)
#
require 'rails_helper'

RSpec.describe Match, type: :model do
  subject { build(:match) }
  describe 'factory' do
    it { is_expected.to be_valid }
  end
  describe 'database' do
    it { is_expected.to have_db_column(:id).of_type(:integer).with_options(null: false) }
  end
  describe 'validations' do
    it 'is expected to validate that a conversation is created' do
      expect {
        FactoryBot.create(:conversation)
      }.to change(Conversation, :count).by(2)
    end
  end
  describe 'associations' do
    it {
      is_expected.to belong_to(:origin_target).class_name('Target')
    }
    it {
      is_expected.to belong_to(:end_target).class_name('Target')
    }
    it { is_expected.to have_one(:conversation).dependent(:destroy) }
  end
end
