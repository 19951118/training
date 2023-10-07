Rails.application.routes.draw do
  devise_for :users
  #ルートパス
  root 'homes#top'
  #ネーミング
  get 'homes/about', as: "about"
  #ルート一括作成、限定
  resources :post_images, only: [:new, :create, :destroy, :show, :index]
end
