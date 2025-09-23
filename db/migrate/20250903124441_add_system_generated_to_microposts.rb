class AddSystemGeneratedToMicroposts < ActiveRecord::Migration[7.0]
  def change
    add_column :microposts, :system_generated, :boolean, default: false
  end
end
