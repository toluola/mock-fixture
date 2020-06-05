Rails.application.routes.draw do
  resources :teams
  post "auth/login" => "users#user_login"
  post "auth/signup" => "users#create"
end
