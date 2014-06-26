module Api
  module V1
    class GamesController < ApplicationController 

      #TODO: refactor loading parent into private method
      #TODO: params.require(:something).permit(x,y) codeschool 4.1

      def index
        player = Player.find(params[:player_id])
        @games = player.games
        #FIXME add dealer filter is there an "except"?
        render json: @games, only: 
          [:id, :player_id, :level, :player_bet, :player_hand, :dealer_hand], 
          status: 200 
      end

      def show
        game = Game.find(params[:id])
        render json: game, status: 200
      end

      

      
      # levels is able to give the id only because there are only 3 games
      def levels
        @games = Game.all
        render json: @games.all, :only => ["id", "level"], status: 200
      end

      # -------------- custom routes --------------------------
      def bet
        #TODO refactor out!
        @player = Player.find(params[:player_id])
        @game = @player.games.find(params[:game_id]);
        @player.bet(@game, params[:bet])
      end

    end
  end
end
