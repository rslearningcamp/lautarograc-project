class AddUserToTargets < ActiveRecord::Migration[6.1]
  def change
    add_reference :targets, :user, null: false, foreign_key: true
  end
end
