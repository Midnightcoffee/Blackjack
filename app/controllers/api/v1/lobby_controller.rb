module Api
  module V1
    class LobbyController < ApplicationController 

      def index
        @player = Player.first
        render json: {
          "level" => 'Beginner', 
          'total_chips' => @player.total_chips}, status: 200
      end

      def create
        # TODO: if they can play game
        # @player = Player.first
        # level = params[:level]
        # TODO: what make sense here?
        # TODO: set game level on game with choosen game 
        render json: {}, status: 200 
      end

    end
  end
end



