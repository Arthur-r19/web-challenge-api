Rails.application.routes.draw do
  resources :tracks, only: %i[index]
  resources :lectures
  post 'lectures/batch', to: 'lectures#create_batch'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
