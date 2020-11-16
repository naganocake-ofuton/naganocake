Rails.application.routes.draw do
  # admin
  devise_for :admins
  namespace :admin do
    # resourses :
    resources :customers,only: [:index, :show, :edit, :update]
    resources :orders,only: [:index, :show, :update]
  end

  # customer
  devise_for :customers
  scope module: :customer do

    get 'about' => 'customer/items#about'
    root to: 'customer/items#top'



    resources :customers,only: [:show, :edit, :update] do
      collection do
        get 'quit'
  	    patch 'out'
      end
    end

    resources :items,only: [:about, :index,:show]

  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
