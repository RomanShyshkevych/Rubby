class AddUserIdToTasks < ActiveRecord::Migration[5.1]
  def change
    add_reference :tasks, :user, type: :uuid, index: true
  end
end
