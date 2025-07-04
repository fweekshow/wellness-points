class AddAliasToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :alias, :string
  end
end
