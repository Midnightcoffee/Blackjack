module Api
  module V1
    class LobbyController < ApplicationController 

      def index
        @player = Player.first
        render json: {
          "level" => 'Beginner', 
          'total_chips' => @player.total_chips}, status: 200
      end

    end
  end
end



