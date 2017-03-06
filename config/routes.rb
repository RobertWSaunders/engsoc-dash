Rails.application.routes.draw do

  resources :job_posting_answers
  # define the index route
  root                     "static_pages#home"
  get   'about'        =>  "static_pages#about"
  get   'contact'      =>  "static_pages#contact"
  get   'credits'      =>  "static_pages#credits"
 
  # devise routes for authentication
  devise_for :users

  get 'organizations/new'
  get 'user_organizations'      =>    'organizations#user_organizations'
  get 'job_postings/manage'     =>    'job_postings#manage', :as => 'manage_job_postings'

  # define the profile routes, linked to the users controller
  resources :profile, :controller => 'users'

  # define the jobs resources
  resources :jobs, only: [:edit, :update, :destroy] do
    # within the jobs routes, route to job applications
    resources :job_applications, :controller => 'jobs/job_applications'
    # resources :job_applications
  end
  
  resources :organizations do
    resources :jobs, only: [:new, :create, :show]
  end

  resources :job_applications, only: [:show, :edit, :update, :destroy] do
  end

  # route to job postings
  resources :job_postings do
    get 'manage'  
    resources :job_posting_questions
    resources :job_applications do
      resources :job_posting_answers, only: [:new, :create, :show]
    end
    member do
      get 'approve'
      get 'withdraw'
    end
  end
end
