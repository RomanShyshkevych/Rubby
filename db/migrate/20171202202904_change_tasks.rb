class ChangeTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :expiry, :datetime, default: Time.current
    add_column :tasks, :importance, :integer, default: 0
  end
end
