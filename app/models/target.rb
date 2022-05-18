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
class Target < ApplicationRecord
  has_many :matches_from_origin, class_name: 'Match', foreign_key: :origin_target_id,
                                 dependent: :destroy, inverse_of: :origin_target
  has_many :matches_to_end, class_name: 'Match', foreign_key: :end_target_id, dependent: :destroy,
                            inverse_of: :end_target
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
  after_create :create_match

  TARGET_LIMIT = 3

  private

  def limit_targets
    limit_error = "You can only have #{TARGET_LIMIT} targets"
    return errors.add(:base, limit_error) if user.targets.count >= TARGET_LIMIT && !user.vip?
  end

  def create_match
    Target.within(radius, origin: [latitude, longitude]).each do |target|
      unless target != self && target.topic_id == topic_id &&
             target.user_id != user_id && target.active == true
        next
      end

      Match.create!(origin_target: self,
                    end_target: target)
    end
  end
end
