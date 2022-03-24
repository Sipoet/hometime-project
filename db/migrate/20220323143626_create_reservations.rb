class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.string :code, null: false, unique: true
      t.string :status, null: false
      t.integer :number_of_guests
      t.date :start_date
      t.date :end_date
      t.integer :number_of_nights
      t.integer :number_of_adults
      t.integer :number_of_children
      t.integer :number_of_infants
      t.integer :currency
      t.decimal :payout_price
      t.decimal :security_price
      t.decimal :total_price
      t.integer :guest_id
      t.timestamps
    end

    add_index :reservations, :code
    add_foreign_key :reservations, :guests
  end
end
