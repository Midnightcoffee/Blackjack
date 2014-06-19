module Api
  module V1
    class GameLevelsController < ApplicationController 

      def index
        @levels = ['Beginner', 'Intermediate', 'High Roller']
        render json: {'game_levels' => @levels}, status: 200
      end
    end
  end
end
