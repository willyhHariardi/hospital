module Sehatq
  module Backyard
    class AdminController < ApplicationController
      before_action :authenticate_admin!
      before_action :default_params, only: :index

      def index
        ransack_instance = Admin.all.ransack(params[:q])
        @admin_users = ransack_instance.result.page(params[:page]).per(params[:limit])
        render locals: { ransack_instance: ransack_instance }
      end

      def new
        @admin_user = Admin.new
      end

      def create
        @admin_user = Admin.new(admin_user_params)
        if @admin_user.save
          redirect_to sehatq_backyard_admin_index_path
        else
          return render 'new'
        end
      end

      def admin_user_params
        permitted = params.require(:admin_user)
        .permit(:name, :password, :email)
      end

      def default_params
        params[:limit] ||= 25
      end
    end
  end
end
