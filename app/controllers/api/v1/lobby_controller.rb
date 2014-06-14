module Api
  module V1
    class LobbyController < ApplicationController 
      def index
        render json: {
          "level" => 'Beginner', 
          'total_chips' => 100}, status: 200
      end
    end
  end
end



