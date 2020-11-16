Rails.application.routes.draw do
  # admin
  devise_for :admins
  namespace :admin do
    # resources :
  end

  # customer
  devise_for :customers
  scope module: :customer do
    resources :shippings, only: [:index, :create, :edit, :update, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
