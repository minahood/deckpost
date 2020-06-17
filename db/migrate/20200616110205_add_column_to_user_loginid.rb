class AddColumnToUserLoginid < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :login_id, :string
  end
end
