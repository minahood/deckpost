class AddColumnToMicropost < ActiveRecord::Migration[6.0]
  def change
    add_column :microposts, :title, :string
  end
  add_index :microposts, :title
end
