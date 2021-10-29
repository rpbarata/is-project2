# frozen_string_literal: true

Rails.application.routes.draw do
  root "trips#index"

  resources :trips
end
