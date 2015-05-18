Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  get '/dashboard', to: 'dashboard#show', as: :dashboard

  resources :tracks, only: [:index, :show] do
    resources :modules, only: [:show], controller: 'learning_modules' do
      resources :lessons, only: [:show] do
        resources :activities, only: [] do
          resources :submissions, only: [:create]
        end
      end
    end
  end

  namespace :admin do
    resources :tracks do
      resources :modules, controller: 'learning_modules' do
        resources :lessons do
          resources :activities
        end
      end
    end
  end

  get '/u/:id', to: 'profiles#show', as: :profile
  get '/leaderboard', to: 'leaderboard#index', as: :leaderboard
end
