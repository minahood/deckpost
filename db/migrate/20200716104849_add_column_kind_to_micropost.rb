class AddColumnKindToMicropost < ActiveRecord::Migration[6.0]
  def change
    add_column :microposts, :kind, :integer, null: false  
  end
end
