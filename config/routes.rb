Rails.application.routes.draw do
  get "fixtures/completed" => "fixtures#view_completed_fixtures"
  get "fixtures/pending" => "fixtures#view_pending_fixtures"
  get "fixtures/:id/link" => "fixtures#generate_fixture_link"
  get "search/teams" => "search#search_team"
  get "search/fixtures" => "search#search_fixture"  

  resources :teams
  resources :fixtures
  
  post "auth/login" => "users#user_login"
  post "auth/signup" => "users#create"
  get "/" => "teams#root"
end
