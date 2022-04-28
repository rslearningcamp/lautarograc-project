class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.references :origin_user, foreign_key: { to_table: :users }, null: false
      t.references :end_user, foreign_key: { to_table: :users }, null: false
      t.references :origin_target, foreign_key: { to_table: :targets }, null: false
      t.references :end_target, foreign_key: { to_table: :targets }, null: false
    end
  end
end
