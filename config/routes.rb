# frozen_string_literal: true

Rails.application.routes.draw do
  resources :payrolls
  resources :employees
  resources :payroll_periods
  resources :companies
  mount_devise_token_auth_for 'User', at: 'auth'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
