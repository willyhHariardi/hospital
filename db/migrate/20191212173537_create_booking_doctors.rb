class CreateBookingDoctors < ActiveRecord::Migration[5.2]
  def change
    create_table :booking_doctors do |t|
      t.string :customer_name
      t.belongs_to :schedule_doctor, index: true, type: :integer
    end
  end
end
