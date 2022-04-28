# == Schema Information
#
# Table name: matches
#
#  id               :bigint           not null, primary key
#  end_target_id    :bigint           not null
#  end_user_id      :bigint           not null
#  origin_target_id :bigint           not null
#  origin_user_id   :bigint           not null
#
# Indexes
#
#  index_matches_on_end_target_id     (end_target_id)
#  index_matches_on_end_user_id       (end_user_id)
#  index_matches_on_origin_target_id  (origin_target_id)
#  index_matches_on_origin_user_id    (origin_user_id)
#
# Foreign Keys
#
#  fk_rails_...  (end_target_id => targets.id)
#  fk_rails_...  (end_user_id => users.id)
#  fk_rails_...  (origin_target_id => targets.id)
#  fk_rails_...  (origin_user_id => users.id)
#
class Match < ApplicationRecord
  belongs_to :origin_user, class_name: 'User'
  belongs_to :end_user, class_name: 'User'
  belongs_to :origin_target, class_name: 'Target'
  belongs_to :end_target, class_name: 'Target'
  has_one :conversation, dependent: :destroy
  after_create :create_conversation

  private

  def create_conversation
    Conversation.create!(match_id: id) unless Conversation.exists?(match_id: id)
  end
end
