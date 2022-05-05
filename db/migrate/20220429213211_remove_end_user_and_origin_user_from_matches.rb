class RemoveEndUserAndOriginUserFromMatches < ActiveRecord::Migration[6.1]
  def up
    remove_reference :matches, :origin_user, null: false, foreign_key: { to_table: :users }
    remove_reference :matches, :end_user, null: false, foreign_key: { to_table: :users }
  end
  def down
    add_reference :matches, :origin_user, null: false, foreign_key: { to_table: :users }
    add_reference :matches, :end_user, null: false, foreign_key: { to_table: :users }
  end
end
