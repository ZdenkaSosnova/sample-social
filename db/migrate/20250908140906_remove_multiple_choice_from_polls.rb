class RemoveMultipleChoiceFromPolls < ActiveRecord::Migration[7.0]
  def change
    remove_column :polls, :multiple_choice, :boolean
  end
end
