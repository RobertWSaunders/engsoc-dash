Rails.application.routes.draw do

  # Take advantage of shallow routing wherever possible:
  # :index, :new, :create should be nested with parent resource
  # :show, :edit, :update, :destroy should be unnested

  root                     "static_pages#home"
  get   'about'        =>  "static_pages#about"
  get   'contact'      =>  "static_pages#contact"
  get   'credits'      =>  "static_pages#credits"
  get   'settings'     =>  "static_pages#settings"

  ####################################################
  # Profiles
  # devise routes for authentication
  devise_for :users
  resources :profiles, :controller => 'users'

  ####################################################
  # Organizations
  resources :organizations do
    member do
      get 'approve'
      get 'withdraw'
      get 'archive'
    end
    collection do
      get 'admin'
      get 'manage'
      get 'user'
      post 'admin', to: 'organizations#filter'
    end
    resources :jobs, only: [:new, :create]
  end

  ####################################################
  # Jobs
  resources :jobs, only: [:show, :edit, :update, :destroy] do
    member do
      get 'assign'
    end
  end

  resources :job_postings do
    resources :job_posting_questions, only: [:index, :create]
    resources :job_applications, only: [:index, :new, :create] do
      resources :job_posting_answers, only: [:new, :create]
    end
    member do
      get 'approve'
      get 'withdraw'
    end
    collection do
      get 'select'
      get 'admin'
      get 'manage'
      post 'admin', to: 'job_postings#filter'
    end
  end

  resources :job_applications, only: [:show, :update, :destroy] do
    resources :job_posting_answers, only: [:edit, :update, :destroy]
    member do
      get 'finalize'
    end
    collection do
      get 'user'
    end
  end

end
