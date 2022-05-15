# == Schema Information
#
# Table name: targets
#
#  id         :bigint           not null, primary key
#  latitude   :decimal(15, 10)  not null
#  longitude  :decimal(15, 10)  not null
#  radius     :float            not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  topic_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_targets_on_latitude                (latitude)
#  index_targets_on_latitude_and_longitude  (latitude,longitude)
#  index_targets_on_longitude               (longitude)
#  index_targets_on_topic_id                (topic_id)
#  index_targets_on_user_id                 (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (topic_id => topics.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Target, type: :model do
  user = FactoryBot.create(:user)
  vip_user = FactoryBot.create(:user, vip: true)
  subject(:target) { build(:target) }
  describe 'factory' do
    it { is_expected.to be_valid }
  end
  describe 'database' do
    it { is_expected.to have_db_column(:latitude).of_type(:decimal).with_options(null: false) }
    it { is_expected.to have_db_column(:longitude).of_type(:decimal).with_options(null: false) }
    it { is_expected.to have_db_column(:radius).of_type(:float) }
    it { is_expected.to have_db_column(:title).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:id).of_type(:integer).with_options(null: false) }
  end
  describe 'validations' do
    it { is_expected.to validate_presence_of(:latitude) }
    it { is_expected.to validate_presence_of(:longitude) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:radius) }
    it {
      is_expected.to validate_numericality_of(:latitude)
        .is_greater_than_or_equal_to(-90).is_less_than_or_equal_to(90)
    }
    it {
      is_expected.to validate_numericality_of(:longitude)
        .is_greater_than_or_equal_to(-180).is_less_than_or_equal_to(180)
    }
    it { is_expected.to validate_numericality_of(:radius).is_greater_than_or_equal_to(0) }

    it 'validates that target limit is not exceeded' do
      expect {
        FactoryBot.create_list(:target, 4, user_id: user.id)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it 'validates that vip has not limit' do
      expect {
        FactoryBot.create_list(:target, 4, user_id: vip_user.id)
      }.not_to raise_error
    end
  end
  describe 'associations' do
    it { is_expected.to belong_to(:topic) }
  end
  it 'is expected to validate that a match is created' do
    expect {
      FactoryBot.create(:match)
    }.to change(Match, :count).by(1)
  end
end
