Rails.application.routes.draw do
  get 'histories/update'
  root "static_pages#home"
  get "static_pages/home"
  resources :exams
  resources :histories
end
