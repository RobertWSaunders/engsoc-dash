Rails.application.routes.draw do

  # In order to add custom routes, it is advised to add it under the current routes section
  # In order to add new resources, add it to the bottom
  # This is a very 'un-Rails'-y way to route, and
  # it is advised that the whole routes system should be refactored in the near future...

  # Take advantage of shallow routing wherever possible:
  # :index, :new, :create should be nested with parent resource
  # :show, :edit, :update, :destroy should be unnested

  root                     "static_pages#home"
  get   'about'        =>  "static_pages#about"
  get   'contact'      =>  "static_pages#contact"
  get   'credits'      =>  "static_pages#credits"
  get   'settings'     =>  "static_pages#settings"

  ####################################################
  # Custom Routes
  get 'jobs/:id/assign'                         =>    'jobs#assign', :as => 'assign_job'
  get 'job_postings/select'                     =>    'job_postings#select', :as => 'select_job'

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
      get 'manage'
      get 'user'
    end
    resources :jobs, only: [:new, :create]
  end

  ####################################################
  # Jobs
  resources :jobs, only: [:show, :edit, :update, :destroy, :assign]

  resources :job_postings do
    resources :job_posting_questions
    resources :job_applications, only: [:index, :new, :create] do
      resources :job_posting_answers, only: [:new, :create, :show, :edit, :update, :index]
    end
    member do
      get 'approve'
      get 'withdraw'
    end
    collection do
      get 'manage'
    end
  end

  resources :job_applications, only: [:show, :destroy] do
    member do
      get 'finalize'
    end
    collection do
      get 'user'
    end
  end

end
