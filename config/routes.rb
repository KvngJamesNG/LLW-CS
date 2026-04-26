Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "static_pages#home"

  # Static pages
  get "learnmore",        to: "static_pages#learnmore"
  get "team",             to: "static_pages#team",     as: :team
  get "contact-us",       to: "static_pages#contactus", as: :contact_us
  get "joinus",           to: "static_pages#joinus",   as: :joinus
  get "hireus",           to: "static_pages#hireus",   as: :hireus
  get "book_appointment", to: "static_pages#redirect"

  # Contact form
  post "/contact", to: "contacts#create", defaults: { format: :json }
  get  "/contact", to: redirect("/")

  # Companies House
  get "/companies",       to: "companies#index",  as: :companies
  get "/companies/fetch", to: "companies#fetch",  as: :fetch_companies
end
