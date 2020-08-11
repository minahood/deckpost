class AddBookmarkcountToMicroposts < ActiveRecord::Migration[6.0]
  def change
    add_column :microposts, :bookmarkcount, :integer, null: false, default: 0
  end
end
