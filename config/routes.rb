Rails.application.routes.draw do
  root 'home#index'

  resources :tracks, only: [:index, :show] do
    resources :modules, only: [:show], controller: 'learning_modules' do
      resources :lessons, only: [:show] do
        resources :activities, only: [] do
          resources :submissions, only: [:create]
        end
      end
    end
  end
end
