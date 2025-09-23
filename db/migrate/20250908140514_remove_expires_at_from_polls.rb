class RemoveExpiresAtFromPolls < ActiveRecord::Migration[7.0]
  def change
    remove_column :polls, :expires_at, :datetime
  end
end
