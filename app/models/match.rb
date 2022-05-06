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
class Match < ApplicationRecord
  belongs_to :origin_target, class_name: 'Target'
  belongs_to :end_target, class_name: 'Target'
  has_one :conversation, dependent: :destroy
  after_create :create_conversation

  scope :from_user, lambda { |user|
                      where(origin_target_id: user.targets.ids).or(
                        where(end_target_id: user.targets.ids)
                      )
                    }

  private

  def create_conversation
    Conversation.create!(match_id: id) unless Conversation.exists?(match_id: id)
  end
end
