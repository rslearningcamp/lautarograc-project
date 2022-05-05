# == Schema Information
#
# Table name: conversations
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  match_id   :bigint           not null
#
# Indexes
#
#  index_conversations_on_match_id  (match_id)
#
# Foreign Keys
#
#  fk_rails_...  (match_id => matches.id)
#
require 'rails_helper'

RSpec.describe Conversation, type: :model do
  subject { build(:conversation) }
  describe 'factory' do
    it { is_expected.to be_valid }
  end
  describe 'database' do
    it { is_expected.to have_db_column(:id).of_type(:integer).with_options(null: false) }
  end
  describe 'associations' do
    it { is_expected.to belong_to(:match) }
  end
end
