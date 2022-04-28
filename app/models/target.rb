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
class Target < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  acts_as_mappable default_units: :kms,
                   default_formula: :sphere,
                   distance_field_name: :distance,
                   lat_column_name: :latitude,
                   lng_column_name: :longitude

  validates :title, presence: true
  validates :latitude, presence: true,
                       numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :longitude, presence: true,
                        numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  validates :radius, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :limit_targets, on: :create

  
  TARGET_LIMIT = 3
  private
  def limit_targets
    limit_error = "You can only have #{TARGET_LIMIT} targets"
    return errors.add(:base, limit_error) if user.targets.count >= TARGET_LIMIT
  end
end
