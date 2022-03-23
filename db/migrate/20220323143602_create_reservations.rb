class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.string :code, null: false, unique: true
      t.string :status, null: false
      t.integer :number_of_guests
      t.timestamps
    end

    add_index :reservations, :code
  end
end
