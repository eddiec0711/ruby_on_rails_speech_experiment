Rails.application.routes.draw do

  devise_for :users, :controllers => {:registrations => "users/registrations",:sessions => "users/sessions"}
  
  match "/403", to: "errors#error_403", via: :all
  match "/404", to: "errors#error_404", via: :all
  match "/422", to: "errors#error_422", via: :all
  match "/500", to: "errors#error_500", via: :all

  get :ie_warning, to: 'errors#ie_warning'
  get :javascript_warning, to: 'errors#javascript_warning'

  root to: "pages#home"
  get 'contact_us' => 'pages#contact_us'
  get 'documentation' => 'pages#documentation'

  #admin  
  scope '/admin' do
    resources :researcher_invitations, only: [:index, :create, :destroy]
    get 'users' => 'admin#users', as: 'admin_see_users'
    get 'view_user' => 'admin#view_user', as: 'view_user'
    post 'set_admin'=> 'admin#set_admin', as: 'set_admin'
    post 'delete_user'=> 'admin#delete_user', as: 'delete_user'
  end

  # resources
  resources :experiments
  resources :question_tasks, only: [:show, :edit, :update, :destroy]
  resources :sample_tasks, only: [:show, :edit, :update, :destroy]
  resources :listening_tasks, only: [:show, :edit, :update, :destroy]
  resources :click_tasks, only: [:show, :edit, :update, :destroy]
  resources :click_responses
  # experiments
  get 'experiments/:id/download' => 'experiments#download', as: 'download_experiment'
  get 'experiments/:id/complete/:force' => 'experiments#complete', as: 'complete_experiment'
  get 'experiments/:id/terms' => 'experiments#terms', as: 'edit_terms'
  patch 'experiments/:id/terms' => 'experiments#update_terms', as: 'update_terms'

  # adding tasks
  get ':taskable_type/:taskable_id/question_task/new' => 'question_tasks#new', as: 'new_question_task'
  post ':taskable_type/:taskable_id/question_task' => 'question_tasks#create', as: 'create_question_task'

  get ':taskable_type/:taskable_id/sample_task/new' => 'sample_tasks#new', as: 'new_sample_task'
  post ':taskable_type/:taskable_id/sample_task' => 'sample_tasks#create', as: 'create_sample_task'

  get ':taskable_type/:taskable_id/listening_task/new' => 'listening_tasks#new', as: 'new_listening_task'
  post ':taskable_type/:taskable_id/listening_task' => 'listening_tasks#create', as: 'create_listening_task'

  get ':taskable_type/:taskable_id/click_task/new' => 'click_tasks#new', as: 'new_click_task'
  post ':taskable_type/:taskable_id/click_task' => 'click_tasks#create', as: 'create_click_task'

  patch ':id/random' => 'tasks#random', as: 'randomise_task'

  # question tasks
  post 'task/:id/add/:type' => 'question_tasks#add_question', as: 'add_question'

  # questions
  resources :questions, only: [:create, :update, :destroy]
  resources :options, only: [:create, :destroy]

  post 'questions/:id/add_option' => 'questions#add_option', as: 'add_option'
  patch 'questions/:id/scale' => 'questions#edit_scale', as: 'edit_scale'

  # sample tasks
  patch 'sample_task/:id/audio' => 'sample_tasks#upload_audio', as: 'upload_audio'
  patch 'sample_task/:id/transcript' => 'sample_tasks#upload_transcript', as: 'upload_transcript'
  
  delete 'sample_task/:id/audio' => 'sample_tasks#destroy_audio', as: 'destroy_audio'
  delete 'sample_task/:id/transcript' => 'sample_tasks#destroy_transcript', as: 'destroy_transcript'

  patch 'sample_task/:id/calibration' => 'sample_tasks#calibration', as: 'sample_calibration'

  # listening tasks
  patch 'listening_task/:id/listens'=> 'listening_tasks#update_listens', as: 'edit_listens'

  # click tasks
  patch 'click_task/:id/prompt'=> 'click_tasks#update_prompt', as: 'edit_click_prompt'

  # responses
  get ':slug/home' => 'responses#index', as: 'index_participant'
  get ':slug/:participant_id/sample/:sample_id' => 'responses#show', as: 'show_response'
  get ':slug/:participant_id/:actable_type/:actable_id/new' => 'responses#new', as: 'new_response'
  post ':slug/:participant_id/:actable_type/:actable_id/add' => 'responses#create', as: 'create_responses'
  get ':slug/finish' => 'responses#finish', as: 'finish_experiment'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
