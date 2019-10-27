class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.references :invitee, index: true
      t.references :listing, index: true
      t.timestamps
    end
  end
end
