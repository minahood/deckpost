class RemoveIndexToUserEmail < ActiveRecord::Migration[6.0]
  def change
    remove_index :users, :email
  end
end
