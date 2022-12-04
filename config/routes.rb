# frozen_string_literal: true

Rails.application.routes.draw do
  get 'task/input', as: 'input'
  root 'task#input'
  get 'task/show', as: 'output'
  get '/task/show_db', as: 'show_db'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
