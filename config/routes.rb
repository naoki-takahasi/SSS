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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
