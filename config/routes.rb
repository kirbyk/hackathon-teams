HackathonTeams::Application.routes.draw do
  root 'pages#root'

  resources :representatives
  resources :sponsors
  resources :teams
  resources :schools
  resources :hackers

  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}

  get 'committed' => 'hackers#committed'

  post 'update_commit/:id' => 'hackers#update_commit'

  get 'stats' => 'stats#index'
end
