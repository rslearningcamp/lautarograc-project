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
class TargetSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :radius, :title
  belongs_to :topic
  belongs_to :user
end
