Rails.application.routes.draw do
  #devise_for :users

  # optimacms devise
  devise_for :cms_admin_users, Optimacms::Devise.config

  match 'demo/:action', to: 'demo#action', via: [:get, :post], as: 'demo'

  if Rails.env.development?
    match 'debug/:action', to: 'debug#action', via: [:get, :post], as: 'debug'
  end


  # admin

  scope '/'+Optimacms.admin_namespace do
    scope module: 'admin', as: 'admin' do

    end
  end


  ### optimacms gems
  #mount OptimacmsOptions::Engine => "/", :as => "cms_options"
  mount OptimacmsBackups::Engine => "/", :as => "cms_backups"

  # !!! LAST row
  mount Optimacms::Engine => "/", :as => "cms"

  # for names
  root to: "home#index"


end
