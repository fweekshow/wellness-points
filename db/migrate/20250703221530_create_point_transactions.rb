class CreatePointTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :point_transactions do |t|
      t.references :giver, null: false, foreign_key: { to_table: :users }
      t.references :receiver, null: false, foreign_key: { to_table: :users }
      t.string :task
      t.integer :points
      t.boolean :claimed
      t.timestamp :claimed_at

      t.timestamps
    end
  end
end
