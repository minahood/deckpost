class AddUserFavarite < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :favorite, :integer
  end
end
