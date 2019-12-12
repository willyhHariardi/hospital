module Sehatq
  module Backyard
    class HospitalController < ApplicationController
      before_action :authenticate_admin!
      before_action :default_params, only: :index

      def index
        ransack_instance = Hospital.all.ransack(params[:q])
        @hospitals = ransack_instance.result.page(params[:page]).per(params[:limit])
        render locals: { ransack_instance: ransack_instance }
      end

      def new
        @hospital = Hospital.new
      end

      def create
        @hospital = Hospital.new(hospital_params)
        if @hospital.save
          redirect_to sehatq_backyard_hospital_index_path
        else
          return render 'new'
        end
      end

      def hospital_params
        permitted = params.require(:hospital)
        .permit(:name, :address)
      end

      def default_params
        params[:limit] ||= 25
      end
    end
  end
end
