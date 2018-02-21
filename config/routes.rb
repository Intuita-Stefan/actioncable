Rails.application.routes.draw do
  get 'charts/messages_per_hour'

  resources :chat_rooms, only: [:new, :create, :show, :index]
  #root 'chat_rooms#index'

  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }

  mount ActionCable.server => '/cable'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'application#index'
  #root 'chat_rooms#index'

end
