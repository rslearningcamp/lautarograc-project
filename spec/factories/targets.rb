# == Schema Information
#
# Table name: targets
#
#  id         :bigint           not null, primary key
#  latitude   :decimal(15, 10)  not null
#  longitude  :decimal(15, 10)  not null
#  radius     :float
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  topic_id   :bigint           not null
#
# Indexes
#
#  index_targets_on_latitude                (latitude)
#  index_targets_on_latitude_and_longitude  (latitude,longitude)
#  index_targets_on_longitude               (longitude)
#  index_targets_on_topic_id                (topic_id)
#
# Foreign Keys
#
#  fk_rails_...  (topic_id => topics.id)
#
FactoryBot.define do
  factory :target do
    title { Faker::Lorem.word }
    radius { 1.5 }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    topic_id { create(:topic).id }
  end
end
