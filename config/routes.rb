Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  root to: "welcome#index"
  resources :achievements
end