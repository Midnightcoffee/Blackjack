module Api
  module V1
    class LevelsController < ApplicationController
      def index
        render json: [{"level" => 'Beginner'}], status: 200
      end
    end
  end
end



