module Api
  module V1
    class GameController < ApplicationController 

      def index
        render json: {'player_hand' => "Spade,10|Spade,Ace"}, status:200
      end

      def create
        #TODO check to see if they can join
        #FIXME should this be a post?
        redirect_to "/game"
      end

    end
  end
end
