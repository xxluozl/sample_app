Rails.application.routes.draw do
  root 'static_pages#home'
  get 'help', to: 'static_pages#help' #as: 'helper' as选项用于创建别名:helper_path
  get 'about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'
  get 'microposts', to: 'static_pages#home'

  get 'sign_up', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users do
    member do  #得到形如localhost:3000/users/1/following的地址，也可用collection方法，但是不会包含id,形如localhost:3000/users/following
      get :following, :followers  #具名路由：following_user_path(id)
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :edit, :create, :update]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
