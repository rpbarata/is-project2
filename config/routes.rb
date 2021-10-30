# frozen_string_literal: true

Rails.application.routes.draw do
  root "trips#index"

  resources :user_tickets, only: [:index, :destroy]
  # get "user_tickets",         to: "user_tickets#index"
  # delete "user_tickets/:id",  to: "user_tickets#destroy", as: "refund"

  get "trips",          to: "trips#index"
  patch "buy_trip/:id", to: "trips#buy_trip", as: "buy_trip"

  get "wallet",   to: "wallet#show"
  patch "wallet", to: "wallet#update"

  get "sign_up",   to: "registrations#new"
  post "sign_up",  to: "registrations#create"
  get "profile",   to: "registrations#edit", as: "edit_profile"
  patch "profile", to: "registrations#update"

  get "sign_in",   to: "sessions#new"
  post "sign_in",  to: "sessions#create", as: "log_in"
  delete "logout", to: "sessions#destroy"
end
