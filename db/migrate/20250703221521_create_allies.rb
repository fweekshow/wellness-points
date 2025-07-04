class CreateAllies < ActiveRecord::Migration[7.1]
  def change
    create_table :allies do |t|
      t.references :user, null: false, foreign_key: true
      t.string :ally_email

      t.timestamps
    end
  end
end
