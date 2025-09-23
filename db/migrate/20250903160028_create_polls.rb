class CreatePolls < ActiveRecord::Migration[7.0]
  def change
    create_table :polls do |t|
      t.references :user, null: false, foreign_key: true
      t.string :question, null: false
      t.datetime :expires_at
      t.boolean :multiple_choice, default: false

      t.timestamps
    end
  end
end
