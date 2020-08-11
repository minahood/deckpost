class AddLikecountToMicropost < ActiveRecord::Migration[6.0]
  def change
    add_column :microposts, :likecount, :integer, null: false, default: 0
  end
end
