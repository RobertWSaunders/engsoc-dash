Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "pages#dashboard"
  resources :profile, :controller => 'users'
resources :job_postings do
  member do
    get 'approve'
    get 'withdraw'
  end
  resources :job_applications
end
  resources :jobs

end
