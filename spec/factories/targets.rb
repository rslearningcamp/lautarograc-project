# == Schema Information
#
# Table name: targets
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
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
FactoryBot.define do
  factory :target do
    title { Faker::Lorem.word }
    radius { 1.5 }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    topic_id { create(:topic).id }
    user_id { create(:user).id }
  end
end
