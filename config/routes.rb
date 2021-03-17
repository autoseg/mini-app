Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :tasks do
    member do
      put :change_privacy
      put :change_status
    end
  end

  get 'report', to: 'reports#index'
  get 'report_pdf', to: 'reports#print_as_pdf'

  resources :profiles, only: %i[show new create update edit] do
    get 'private_page', on: :member
    post 'change_privacy', on: :member
    resources :comments, only: %i[index]
  end

  resources :comments, only: %i[create destroy]
  resources :pluses, only: %i[create destroy]
  resources :minuses, only: %i[create destroy]
end
