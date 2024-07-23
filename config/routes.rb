Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  resources :studytimes do
    collection do
      get 'search_users'
    end
  end

  get '/studytimes/user/:user_name', to: 'studytimes#user_studytime', as: 'user_studytime'

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
