module Api
  module V1
    class GamesController < ApplicationController 

      #TODO: refactor loading parent into private method
      #TODO: params.require(:something).permit(x,y) codeschool 4.1

      def index
        player = Player.find(params[:player_id])
        @games = player.games
        #FIXME add dealer filter
        render json: @games, status: 200
          
      end

      def show
        game = Game.find(params[:id])
        render json: game, status: 200
          
      end

      

      def create

        #FIXME: better way to check?
        levels = ['Beginner','Intermediate', 'High Roller']
        if params['level'].in? levels
          #FIXME better way to update
          @game = Game.create(level: params['level'])
          render json: {'game_id' => @game.id}, status: 201
        else
          render json: {'error' => "Not acceptable level - #{params['level']}"}, 
            status: 422
        end
      end

      # def show
      #   # TODO: current mock data
      #   #FIXME: don't always need to send back his amount
      #   render json: {'level' => 'FakeBeginner', 'amount' => "#{@game.player_bet}"}, status:200
      #   #TODO: how do i have it condition on state of game?
      # end

      # # BET, HIT, HOLD
      # def update

      #   @game = Game.first
      #   puts "--------------- UPDATE REACHED -------------"
      #   @game.player_bet = params[:bet]
      #   bet = @game.player_bet
        
      #   # assuming everything checks out!
      #   @game.save!
      #   render json: {"currentBet" => "#{@game.player_bet}"}, status: 200 
      # end
    end
  end
end
