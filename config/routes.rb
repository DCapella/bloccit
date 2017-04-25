Rails.application.routes.draw do
  resources :topics do
    resources :posts, except: [:index]
  end
  resources :advertisements
  resources :users, only: [:new, :create]


  get 'about' => 'welcome#about'

  root 'welcome#index'

end
