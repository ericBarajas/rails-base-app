Myrails::Application.routes.draw do

  devise_for :users, :controllers => { :registrations => :registrations }
  devise_for :admins

  #root to: "home#index", :as=>'home'
  #resources :home, only: :index

  #
  get 'debug/:action' => 'debug#action', as: :debug

  # callback
  #mount CallbackForm::Engine, at: "/callback"

  # pages
  #get ':page.html' => 'pages#show', as: :page

  # the last!!!
  mount Optimacms::Engine => "/", :as => "cms"


end
