Rails.application.routes.draw do
  # admin
  devise_for :admins
  namespace :admin do
    # resourses :
  end

  # customer
  devise_for :customers, :controllers => {
    :sessions => 'customers/sessions',
    :registrations => 'customers/registrations',
    :passwords => 'customers/passwords'
   }
  scope module: :customer do
    # resourses :
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
