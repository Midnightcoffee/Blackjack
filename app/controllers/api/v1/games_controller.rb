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
        #FIXME bet to player_bet
        @player_bet = params[:player_bet]

        #FIXME: better flow control
        if @player.enough_chips?(@player_bet) && @game.within_range?(@player_bet)
          @player.total_chips -= @player_bet
          @game.player_bet = @player_bet
          #FIXME: pass along players how to include players
          @game.deal
          #TODO anyway to make this update an all or nothing?
          #include player bet?
          #DEAL
          @player.save!
          @game.save!

          return render json: @game, only: 
            [:id, :player_id, :level, :player_bet, :player_hand, :dealer_hand], 
            status: 201
        end
        #FIXME: bettor error
        return render json: {error: "something went wrong"}, status: 403

      end

    end
  end
end
