module Api
  module V1
    class GamesController < ApplicationController 

      #TODO: refactor loading parent into private method
      #TODO: params.require(:something).permit(x,y) codeschool 4.1

      def index
        #FIXME add a index route for just games/
        @player = Player.find(params[:player_id])
        @games = @player.games
        #FIXME add dealer filter is there an "except"?
        render json: @games, only: 
          [:id, :player_id, :level, :player_bet, :player_hand, :dealer_hand], 
          status: 200 
      end

      def show
        #FIXME is there a more rails way to do a query?
        # @game = Game.where("player_id = ? AND id = ?", params[:player_id], params[:id])
        # FIXME how to do query with player? The unexpectedly gave an array
        @game = Game.find(params[:id])
        render json: @game, status: 200
      end

      
      # levels is able to give the id only because there are only 3 games
      # -------------- custom routes --------------------------
      def levels
        @games = Game.all
        render json: @games.all, :only => ["id", "level"], status: 200
      end


      def bet
        #TODO refactor out!
        @player = Player.find(params[:player_id])
        @game = @player.games.find(params[:id]);
        if @player.bet(@game, params[:player_bet])
          render json: @game, only: 
            [:id, :player_id, :level, :player_bet, :player_hand, :dealer_hand], 
            status: 200 
        else
          #FIXME error message
          render json: {}, status: 400
        end

      end

    end
  end
end
