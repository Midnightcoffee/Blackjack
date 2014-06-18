module Api
  module V1
    class GameController < ApplicationController 

      def index
        # TODO: current mock data
        @game = Game.first
        render json: {'level' => 'Beginner', 'amount' => "#{@game.player_bet}"}, status:200
        #TODO: how do i have it condition on state of game?
      end

      def create
        # TODO: if bet within limits and they have enough chips
        # @game = get bet from player
        # @game.start
        # can you play
        # TODO: consider game.find_by(1) vs game.first
        @game = Game.first
        #TODO go in model?
        @game.player_bet = params[:bet]
        @game.save!
        render json: {"currentBet" => "#{@game.player_bet}"}, status: 200 
        
      end

      def get_incoming_request
        can you play
        if so 
          something
        else
        end


      end



    end
  end
end
