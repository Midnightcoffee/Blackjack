module Api
  module V1
    class GamesController < ApplicationController 

      def create

        #FIXME: better way to check?
        levels = ['Beginner','Intermediate', 'High Roller']
        if params['level'].in? levels
          #FIXME better way to update
          @game = Game.create(level: params['level'])
          render json: {'game_id' => @game.id}, status:200
        else
          render json: {'error_message' => 'not acceptable level'}, status:404
        end
      end

      def show
        # TODO: current mock data
        #FIXME: don't always need to send back his amount
        render json: {'level' => 'FakeBeginner', 'amount' => "#{@game.player_bet}"}, status:200
        #TODO: how do i have it condition on state of game?
      end

      # BET, HIT, HOLD
      def update

        @game = Game.first
        puts "--------------- UPDATE REACHED -------------"
        @game.player_bet = params[:bet]
        bet = @game.player_bet
        
        # assuming everything checks out!
        @game.save!
        render json: {"currentBet" => "#{@game.player_bet}"}, status: 200 
      end
    end
  end
end
