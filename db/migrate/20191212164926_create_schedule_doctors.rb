class CreateScheduleDoctors < ActiveRecord::Migration[5.2]
  def change
    create_table :schedule_doctors do |t|
      t.date :schedule
      t.belongs_to :doctor, index: true, type: :integer
      t.time :start_time
      t.time :end_time
    end
  end
end
