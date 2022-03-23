class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.string :code, null: false
      t.timestamps
    end
  end
end
