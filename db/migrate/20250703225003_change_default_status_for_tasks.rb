class ChangeDefaultStatusForTasks < ActiveRecord::Migration[7.1]
  def change
    change_column_default :tasks, :status, from: nil, to: 'pending'
  end
end
