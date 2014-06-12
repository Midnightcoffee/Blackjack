module Api
  module V1
    class LobbyController < ApplicationController 
      @player = Player.first
      puts Player.class
      def index
        #TODO: totalChips should come from player
        render json: {
          "level" => 'Beginner', 
          'totalChips' => @player.total_chips}, status: 200
      end
    end
  end
end



