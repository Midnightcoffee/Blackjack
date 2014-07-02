module Api
  module V1
    class PlayersController < ApplicationController 

      def show
        @player = Player.first
        render json: @player, status: 200
      end
    end
  end
end
