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
  get 'user_organizations'            =>    'organizations#user_organizations'
  get 'organizations/manage'          =>    'organizations#manage'
  get 'job_postings/manage'           =>    'job_postings#manage', :as => 'manage_job_postings'
  get 'job_postings/select'           =>    'job_postings#select', :as => 'select_job'
  get 'jobs/:id/assign'               =>    'jobs#assign', :as => 'assign_job'
  get 'job_applications/:id/finalize' =>    'job_applications#finalize', :as => 'finalize_job_application'

  # define the profile routes, linked to the users controller
  resources :profiles, :controller => 'users'

  # define the jobs resources
  resources :jobs, only: [:edit, :update, :destroy, :assign] do
    # within the jobs routes, route to job applications
    resources :job_applications, :controller => 'jobs/job_applications'
    # resources :job_applications
    resources :job_postings, only: [:new]
  end

  resources :organizations do

    resources :jobs, only: [:new, :create, :show]
    member do
      get 'approve'
      get 'withdraw'
    end
  end

  resources :job_applications, only: [:show, :edit, :update, :destroy] do
  end

  # route to job postings
  resources :job_postings do
    get 'manage'
    resources :job_posting_questions
    resources :job_applications do
      resources :job_posting_answers, only: [:new, :create, :show, :edit, :index]
    end
    member do
      get 'approve'
      get 'withdraw'
    end
  end
end
