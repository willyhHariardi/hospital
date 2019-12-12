class ScheduleDoctor < ApplicationRecord
  validates :schedule, presence: true
  belongs_to :doctor
  validates :start_time, presence: true
  validates :end_time, presence: true
  has_many :booking_doctors
end