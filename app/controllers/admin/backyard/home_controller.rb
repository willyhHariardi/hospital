module Admin
  module Backyard
    class HomeController < ApplicationController
      before_action :authenticate_admin!
      def index
      end
    end
  end
end
