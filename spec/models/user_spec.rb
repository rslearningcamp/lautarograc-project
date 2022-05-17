require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }
  subject(:vip_user) { build(:vip_user) }
  describe 'factory' do
    it { is_expected.to be_valid }
  end
  describe 'database' do
    it { is_expected.to have_db_column(:email).of_type(:string).with_options(null: true) }
    it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: true) }
    it { is_expected.to have_db_column(:id).of_type(:integer).with_options(null: false) }
  end
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
    it { is_expected.to validate_length_of(:password).is_at_most(128) }
  end
  describe 'associations' do
    it { is_expected.to have_many(:targets) }
  end
end
