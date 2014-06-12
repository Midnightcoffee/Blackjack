module Api
  module V1
    class LobbyController < ApplicationController
      def index
        render json: {"level" => 'Beginner', 'totalChips' => '0'}, status: 200
      end
    end
  end
end



