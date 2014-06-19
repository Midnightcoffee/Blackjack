module Api
  module V1
    class GameController < ApplicationController 

      def index
        # TODO: current mock data
        @game = Game.first
        #FIXME: don't always need to send back his amount
        render json: {'level' => 'Beginner', 'amount' => "#{@game.player_bet}"}, status:200
        #TODO: how do i have it condition on state of game?
      end

      # def create
      #   # if bet then were in play
      #   @game = Game.first
      #   # can you play
      #   # TODO: consider game.find_by(1) vs game.first
      #   # FIXME: bet should actual create the game object
      #   @game = Game.first
      #   #TODO go in model?
      #   @game.player_bet = params[:bet]
      #   @game.save!
      #   render json: {"currentBet" => "#{@game.player_bet}"}, status: 200 
        
      # end

      # BET, HIT, HOLD trigger update
      def update

        @game = Game.first
        puts "--------------- UPDATE REACHED -------------"
        #FIXME this is just a tracebullet code
        @game.player_bet = params[:bet]
        bet = @game.player_bet
        # TODO: see long if chain below
        
        # assuming everything checks out!
        @game.save!
        render json: {"currentBet" => "#{@game.player_bet}"}, status: 200 
        
        # probable want to put this logic inside another concept/object
        # Solved by having api/v1/bet
        # Mapping out the concept
        # if @player.total_chips is enough
        #   if @game.player_bet
        #     if param[:hit] and param[:hold]
        #       Error
        #     elsif param[:hit] 
        #       then hit 
        #     elsif param[:hold]
        #       then hold
        #     end

        #   else
        #     if bet is legal, then start game and save bet
        #   else
        #     tell them error based on state. For example "bet already placed" or
        #       "you already bet this hand"
        #   end
        # else
        #   tell them they don't have enough chips
        #   redirect back to lobby OR credit 100 chips and keep them at beginner
        #   some message
        # end

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
