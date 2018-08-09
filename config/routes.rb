Rails.application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  root to: "welcome#index"
  resources :achievements
end
