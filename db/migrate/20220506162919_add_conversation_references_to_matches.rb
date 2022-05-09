class AddConversationReferencesToMatches < ActiveRecord::Migration[6.1]
  def change
    add_reference :matches, :conversation, foreign_key: true
  end
end
