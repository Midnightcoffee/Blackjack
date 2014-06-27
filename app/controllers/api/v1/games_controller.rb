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

      

      # -------------- custom routes --------------------------
      def levels
        @games = Game.all
        # levels is able to return the ids only because there are only 3 games
        render json: @games.all, :only => ["id", "level"], status: 200
      end


      def bet
        @player = Player.find(params[:player_id])
        @game = @player.games.find(params[:id]);
        @bet = params[:bet]

        if @player.enough_chips? @bet && @game.within_range? @bet
          @player.total_chips -= @bet
          @game.player_bet = @bet
          #TODO anyway to make this update an all or nothing?
          #include player bet?
          if @player.save && @game.save
            render json: @game, only: 
              [:id, :player_id, :level, :player_bet, :player_hand, :dealer_hand], 
              status: 200 

        end
        #FIXME: bettor error
        render json: {error: "something went wrong"}, status: 400

      end

    end
  end
end
