Edgar::Application.routes.draw do
  scope ":locale", locale: /#{I18n.available_locales.join("|")}/  do
    authenticated :user do
      root :to => 'home#index'
    end
    devise_scope :user do
      root :to => "devise/registrations#new", :as => "locale_root"
      match '/user/confirmation' => 'confirmations#update', :via => :put, :as => :update_user_confirmation
    end
    devise_for :users, :controllers => { :registrations => "registrations", :confirmations => "confirmations" }
    match 'users/bulk_invite/:quantity' => 'users#bulk_invite', :via => :get, :as => :bulk_invite
    resources :users do
      get 'invite', :on => :member
    end
  end

# handles /
  root to: redirect("/#{I18n.default_locale}")
  match '*path', :to => 'errors#routing'
end
