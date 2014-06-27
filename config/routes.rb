Blackjack::Application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :players, only: [:show] do
        resources :games, only: [:index, :show] do
          member do
            put 'bet'
          end
        end
      end
      #TODO: think about what you want to expose here?
      resources :games, only: [] do
        collection do
          get 'levels'
        end
      end
    end
  end
  root to: "main#index"
end
