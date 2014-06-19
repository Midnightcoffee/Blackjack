module Api
  module V1
    class TotalChipsController < ApplicationController 

      def show
        @player = Player.find(1)
        render json: {'total_chips' => @player.total_chips}, status: 200
      end
    end
  end
end
