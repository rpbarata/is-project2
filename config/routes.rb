# frozen_string_literal: true

require "sidekiq/web"

Rails.application.routes.draw do
  namespace :manager do
    mount Sidekiq::Web => "/sidekiq"
    mount Maily::Engine, at: "/maily"

    resources :trips
    resources :passengers, only: [:index]
  end

  resources :user_tickets, only: [:index, :destroy]

  get "trips",          to: "trips#index"
  patch "buy_trip/:id", to: "trips#buy_trip", as: "buy_trip"

  get "wallet",   to: "wallet#show"
  patch "wallet", to: "wallet#update"

  get "sign_up",   to: "registrations#new"
  post "sign_up",  to: "registrations#create"
  get "profile",   to: "registrations#edit", as: "edit_profile"
  patch "profile", to: "registrations#update"
  delete "delete_account", to: "registrations#destroy"

  get "sign_in",   to: "sessions#new"
  post "sign_in",  to: "sessions#create", as: "log_in"
  delete "logout", to: "sessions#destroy"

  root "trips#index"
end
