class CreateGuests < ActiveRecord::Migration[7.0]
  def change
    create_table :guests do |t|
      t.string :email, null: false, unique: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.timestamps
    end
    add_index :guests, :email
  end
end
