class AddActiveToTargets < ActiveRecord::Migration[6.1]
  def change
    add_column :targets, :active, :boolean, default: true
  end
end
