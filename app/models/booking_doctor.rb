class BookingDoctor < ApplicationRecord
    validates :customer_name, presence: true
    belongs_to :schedule_doctor
  end