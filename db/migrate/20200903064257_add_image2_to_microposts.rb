class AddImage2ToMicroposts < ActiveRecord::Migration[6.0]
  def change
    add_column :microposts, :image2, :string
  end
end
