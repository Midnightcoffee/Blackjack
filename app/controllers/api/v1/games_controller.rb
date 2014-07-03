module Api
  module V1
    class GamesController < ApplicationController 

      def index
        @player = Player.find(params[:player_id])
        @games = @player.games
        render json: @games, except: Game.hidden, status: 200 
      end

      def show
        @game = Game.find(params[:id])
        render json: @game, except: Game.hidden, status: 200
      end

      # -------------- custom routes --------------------------
      def levels
        @games = Game.order(:id)
        render json: @games, only: [:id, :level, :min_bet, :max_bet, :player_bet], status: 200
      end

      def bet
        @player = Player.find(params[:player_id])
        @game = @player.games.find(params[:id]);
        @player_bet = params[:player_bet]

        if @game.legal_bet?(@player, @player_bet)
          @game.clear_hands
          @game.place_bet @player, @player_bet
          @game.deal

          render json: @game, except: Game.hidden, status: 201
        else
          #FIXME: bettor error message  move message to centralized place
          @game.message = "Bet wasn't placed"
          @game.save
          render json: @game, except: Game.hidden, status: 403
        end
      end

      def hit
        @player = Player.find(params[:player_id])
        @game = @player.games.find(params[:id]);
        if @game.player_bet != 0
          #TODO: better way to reference were hitting on player
          @game.player_hit
          render json: @game, except: Game.hidden, status: 201
        else
          render json: @game, except: Game.hidden, status: 403
        end
      end

      def stand
        @player = Player.find(params[:player_id])
        @game = @player.games.find(params[:id]);
        if @game.player_bet != 0

          #TODO: better way to reference were hitting on player
          @game.stand
          render json: @game, except: Game.hidden, status: 201
        else
          render json: @game, except: Game.hidden, status: 403
        end
      end
    end
  end
end
