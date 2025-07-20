Rails.application.routes.draw do
  get 'companies/index'
  get 'companies/fetch'
  get 'appointments/new'
  get 'appointments/create'
  get 'appointments/index'
  get 'pages/contact'
  resources :applicants, path: "careers" do
  resources :jobs, only: [:index, :show]
  resources :applications, only: [:create]
  # config/routes.rb
resources :appointments, only: [:new, :create, :index]

    collection do
      get "thank_you", to: "applicants#thank_you"
    end
  end

  get 'static_pages/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "static_pages#home"

  get "index", to: "jobs#index", as: :index

  post '/contact', to: 'contacts#create', defaults: { format: :json }

  get '/contact', to: redirect('/')

  get "contact-us", to: "static_pages#contactus", as: :contact_us

  get "learnmore", to: "static_pages#learnmore"

  get "team", to: "static_pages#team", as: :team

  get "joinus", to: "static_pages#joinus", as: :joinus

  get "hireus", to: "static_pages#hireus", as: :hireus

  get "/companies", to: "companies#index"
  
  get "/companies/fetch", to: "companies#fetch"

  get 'book_appointment', to: 'static_pages#redirect'

end
