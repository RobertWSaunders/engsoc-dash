Rails.application.routes.draw do

  # devise routes for authentication
  devise_for :users

  # define the index route
  root to: "pages#dashboard"

  # define the profile routes, linked to the users controller
  resources :profile, :controller => 'users'

  # define the jobs resources
  resources :jobs do
    # within the jobs routes, route to job applications
    resources :job_applications
    end
  end

  # route to job postings
  resources :job_postings do
    member do
      get 'approve'
      get 'withdraw'
    end
end
