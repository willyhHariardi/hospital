module Sehatq
  module Backyard
    class DoctorController < ApplicationController
      before_action :authenticate_admin!
      before_action :default_params, only: :index

      def index
        ransack_instance = Doctor.all.ransack(params[:q])
        @doctors = ransack_instance.result.page(params[:page]).per(params[:limit])
        render locals: { ransack_instance: ransack_instance }
      end

      def new
        @hospitals = Hospital.all
        @doctor = Doctor.new
      end

      def create
        @doctor = Doctor.new(hospital_params)
        if @doctor.save
          redirect_to sehatq_backyard_doctor_index_path
        else
          @hospitals = Hospital.all
          return render 'new'
        end
      end

      def hospital_params
        permitted = params.require(:doctor)
                .permit(:name, :hospital_id)
      end

      def default_params
        params[:limit] ||= 25
      end
    end
  end
end
