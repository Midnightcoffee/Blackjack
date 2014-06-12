module Api
  module V1
    class LobbyController < ApplicationController
      def index
        render json: [{"level" => 'Beginner'}], status: 200
      end
    end
  end
end



