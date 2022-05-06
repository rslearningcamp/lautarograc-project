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
FactoryBot.define do
  factory :match do
    origin_target { create(:target) }
    end_target { create(:target) }
  end
end
