Rails.application.routes.draw do
  get 'pages/contact'
  resources :applicants, path: "careers" do
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

  post '/contact', to: 'contacts#create', defaults: { format: :json }

  get '/contact', to: redirect('/')

  get "contact-us", to: "pages#contact", as: :contact_us


end
