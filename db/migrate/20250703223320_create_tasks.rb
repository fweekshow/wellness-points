class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :ally, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.integer :points
      t.string :status
      t.date :due_date

      t.timestamps
    end
  end
end
