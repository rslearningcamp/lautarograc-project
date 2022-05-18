class AddVipToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :vip, :boolean, default: false
  end
end
