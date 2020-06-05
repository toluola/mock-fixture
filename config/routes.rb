Rails.application.routes.draw do
  post "auth/login" => "users#user_login"
  post "auth/signup" => "users#create"
end
