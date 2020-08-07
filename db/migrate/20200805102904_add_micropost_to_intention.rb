class AddMicropostToIntention < ActiveRecord::Migration[6.0]
  def change
    add_column :microposts, :intention, :string
  end
end
