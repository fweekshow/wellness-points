class AddAllyUserIdToAllies < ActiveRecord::Migration[7.1]
  def change
    add_column :allies, :ally_user_id, :integer
  end
end
