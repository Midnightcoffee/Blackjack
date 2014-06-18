module Api
  module V1
    class GameController < ApplicationController 

      def index
        # TODO: current mock data
        render json: {'level' => 'Beginner'}, status:200
      end

      def create
        # TODO: if bet within limits and they have enough chips
        # @game = get bet from player
        # @game.start
        # can you play
        #
        render json: {}, status: 200 
        
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
