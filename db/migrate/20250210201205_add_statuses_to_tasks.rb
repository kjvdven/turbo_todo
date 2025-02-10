class AddStatusesToTasks < ActiveRecord::Migration[8.0]
  def change
    add_column :tasks, :status, :string, default: "in_progress", null: false
  end
end
