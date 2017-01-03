Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "pages#dashboard"
  resources :profile, :controller => 'users'
  resources :jobs
  resources :job_postings
end
