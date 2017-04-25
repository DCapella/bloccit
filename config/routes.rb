Rails.application.routes.draw do
  resources :topics do
    resources :sponsored_posts
    resources :posts, except: [:index]
  end
  # resources :advertisements


  get 'about' => 'welcome#about'

  root 'welcome#index'

end
