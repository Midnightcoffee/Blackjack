module Api
  module V1
    class GameController < ApplicationController 

      def index
        render json: {'player_hand' => "Spade,10|Spade,Ace"}, status:200
      end

      def create
        # TODO: handle if they can join this game
        # and if so then have model join them to it
        # break logic up between models
        redirect_to '/game'
      end


    end
  end
end
