class AddIndexToUserLoginid < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :login_id, unique: true
  end
end
