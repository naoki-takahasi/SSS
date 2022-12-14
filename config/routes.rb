Rails.application.routes.draw do
  #管理者#
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }
  #酒造会員#
  devise_for :breweries, skip: [:passwords], controllers: {
  registrations: "brewery/registrations",
  sessions: 'brewery/sessions'
  }
  #販売会員#
  devise_for :shops, skip: [:passwords], controllers: {
  registrations: "shop/registrations",
  sessions: 'shop/sessions'
  }

  #一般閲覧者、販売会員のゲストユーザーとして扱う#
  devise_scope :shop do
    post 'shops/guest_sign_in' => 'shop/sessions#guest_sign_in', as: 'shop/guest_sign_in'
  end

  #初期画面#
  root to: "homes#top"
  get "about" => "homes#about", as: "about"

  #管理者ルーティング#
  namespace :admin do
    root to: "homes#top"
    resources :tags, only: [:index, :create, :edit, :update, :destroy]
    resources :breweries, only: [:show, :index, :edit, :update, :destroy]
    resources :shops, only: [:show, :index, :edit, :update, :destroy]
    resources :sakes, only: [:show, :index, :edit, :update, :destroy] do
      resources :comments, only: [:destroy]
    end
  end

  #酒造会員ルーティング#
  namespace :brewery do
    get "my_page/:id" => "breweries#show", as: "my_page"
    get "my_page/:id/edit" => "breweries#edit", as: "my_page/edit"
    patch "my_page/:id" => "breweries#update", as: "my_page/update"
    get "close/:id" => "breweries#close", as: "close"
    patch "withdraw/:id" => "breweries#withdraw", as: "withdraw"

    resources :shops, only: [:show, :index] do
      resource :relationships, only: [:create, :destroy]
      get "followed" => "relationships#followed"
    end
    resources :sakes, only: [:new, :create, :show, :edit, :index, :update]
  end

  #販売会員ルーティング#
  namespace :shop do
    get "my_page/:id" => "shops#show", as: "my_page"
    get "my_page/:id/edit" => "shops#edit", as: "my_page/edit"
    patch "my_page/:id" => "shops#update", as: "my_page/update"
    get "close/:id" => "shops#close", as: "close"
    patch "withdraw/:id" => "shops#withdraw", as: "withdraw"

    resources :breweries, only: [:show, :index]
    resources :sakes, only: [:show, :index] do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
