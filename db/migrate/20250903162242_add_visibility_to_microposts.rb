class AddVisibilityToMicroposts < ActiveRecord::Migration[7.0]
  def change
    add_column :microposts, :visibility, :string, default: "public", null: false
    add_index :microposts, :visibility
  end
end
