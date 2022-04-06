class CreateTargets < ActiveRecord::Migration[6.1]
  def change
    create_table :targets do |t|
      t.string :title, null: false
      t.float :radius, null: false
      t.decimal :latitude,  :precision => 15, :scale => 10, null: false
      t.decimal :longitude, :precision => 15, :scale => 10, null: false
      t.references :topic, null: false, foreign_key: true

      t.timestamps
    end

    add_index :targets, :latitude
    add_index :targets, :longitude
    add_index :targets, [:latitude, :longitude]
  end
end
