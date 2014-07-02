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
          [:id, :player_id, :level, :player_bet, :player_hand, :dealer_hand, :message], 
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
        @games = Game.order(:id)
        # levels is able to return the ids only because there are only 3 games
        render json: @games, :only => ["id", "level"], status: 200
      end

      def bet
        @player = Player.find(params[:player_id])
        @game = @player.games.find(params[:id]);
        @player_bet = params[:player_bet]

        if @game.legal_bet?(@player, @player_bet)
          @game.clear_hands
          @game.place_bet @player, @player_bet
          @game.deal

          render json: @game, only: 
            [:id, :player_id, :level, :player_bet, :player_hand, :dealer_hand, :message], 
            status: 201
        else
          #FIXME: bettor error message  move message to different place
          @game.message = "You can't bet right now as you already bet for this hand"
          @game.save
          render json: @game, only: 
            [:id, :player_id, :level, :player_bet, :player_hand, :dealer_hand, :message], 
            status: 403
        end
      end

      def hit
        #TODO: refactor out pulling params into parent method
        #TODO: possible need game states
        @player = Player.find(params[:player_id])
        @game = @player.games.find(params[:id]);
        if @game.player_bet != 0
          #TODO: better way to reference were hitting on player

          @game.hit "player"
          render json: @game, only: 
              [:id, :player_id, :level, :player_bet, :player_hand, :dealer_hand, :message], 
              status: 201
        else

          render json: @game, only: 
              [:id, :player_id, :level, :player_bet, :player_hand, :dealer_hand, :message], 
              status: 403
        end
      end

      def stand
        #TODO: refactor out pulling params into parent method
        #TODO: possible need game states
        #FIXME: player bet control in multiple places
        @player = Player.find(params[:player_id])
        @game = @player.games.find(params[:id]);
        if @game.player_bet != 0

          #TODO: better way to reference were hitting on player
          @game.stand
          render json: @game, only: 
              [:id, :player_id, :level, :player_bet, :player_hand, :dealer_hand, :message], 
              status: 201
        else
          #FIXME: better error, do we need an else
          render json: @game, only: 
              [:id, :player_id, :level, :player_bet, :player_hand, :dealer_hand, :message], 
              status: 403
        end
      end
    end
  end
end
