Rails.application.routes.draw do
  root 'games#index'

  get :play_game, to: 'games#play', as: :play_game
end
