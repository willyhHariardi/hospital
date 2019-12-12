module Sehatq
  module Backyard
    class ScheduleDoctorController < ApplicationController
      before_action :authenticate_admin!
      before_action :default_params, only: :index

      def index
        ransack_instance = ScheduleDoctor.all.ransack(params[:q])
        @schedule_doctors = ransack_instance.result.page(params[:page]).per(params[:limit])
        render locals: { ransack_instance: ransack_instance }
      end

      def new
        @doctors = Doctor.all
        @schedule = ScheduleDoctor.new
      end

      def create
        @schedule = ScheduleDoctor.new(schedule_params)
        if @schedule.save
          redirect_to sehatq_backyard_schedule_doctor_index_path
        else
          @doctors = Doctor.all
          return render 'new'
        end
      end

      def schedule_params
        permitted = params.require(:schedule_doctor)
          .permit(:schedule, :doctor_id, :start_time, :end_time)
      end

      def default_params
        params[:limit] ||= 25
      end
    end
  end
end
