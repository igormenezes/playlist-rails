class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :email
      t.integer :age
      t.integer :administrator, default: 0, limit: 1

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
