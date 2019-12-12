module Sehatq
  module Backyard
    class BookingDoctorController < ApplicationController
      before_action :authenticate_admin!
      before_action :default_params, only: :index
      before_action :query, only: %i[new create]

      def index
        ransack_instance = BookingDoctor.all.ransack(params[:q])
        @booking_doctors = ransack_instance.result.page(params[:page]).per(params[:limit])
        render locals: { ransack_instance: ransack_instance }
      end

      def new
        @booking_doctor = BookingDoctor.new
      end

      def create
        @booking_doctor = BookingDoctor.new(schedule_doctor_params)
        if @booking_doctor.save
          redirect_to sehatq_backyard_booking_doctor_index_path
        else
          return render 'new'
        end
      end

      def schedule_doctor_params
        permitted = params.require(:booking_doctor)
        .permit(:customer_name, :schedule_doctor_id)
      end

      def query
       # Query
        # The maximum user can book within 30 minutes before the doctor starts the schedule.
        #A total of 10 users can book the same doctor.
        ctime = Time.now + 30.minutes
        @schedule_doctors = ScheduleDoctor.select("schedule_doctors.*").joins(:booking_doctors)
                                          .group("schedule_doctors.id")
                                          .having("count(booking_doctors.id) < ?", 10)
                                          .where("Date(schedule_doctors.schedule) >= ?  ", Time.zone.today)
                                          .where("TIME(schedule_doctors.start_time) >= ? ", ctime.strftime('%H:%M'))
      end


      def default_params
        params[:limit] ||= 25
      end
    end
  end
end
