module Api
  module V1
    class ChooseGameLevelsController < ApplicationController 

      def update
        @player = Player.find(1)
        @game = @player.game 
        levels = ['Beginner', 'Intermediate', 'High Roller']

        level_picked = params[:level]
        if level_picked.in? levels
          @game.level = level_picked
          @game.save!

          #FIXME: should just be a status code
          render json: {}, status: 200
        else
          render json: {}, status: 404
        end
      end
    end
  end
end
