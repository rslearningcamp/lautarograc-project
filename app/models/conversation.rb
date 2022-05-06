# == Schema Information
#
# Table name: conversations
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  match_id   :bigint           not null
#
# Indexes
#
#  index_conversations_on_match_id  (match_id)
#
# Foreign Keys
#
#  fk_rails_...  (match_id => matches.id)
#
class Conversation < ApplicationRecord
  belongs_to :match
  has_many :messages, dependent: :destroy
end
