Rails.application.routes.draw do
  devise_for  :admins, :path => 'admin/backyard',
              controllers: { registrations: "registrations" },
              :path_names => {
                :sign_in => "login",
                :sign_out => "logout",
              }

  root :to => "landing#index"

  get 'admin/backyard', to: "admin/backyard/home#index", as: 'home_dashboard'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  authenticated do
    root :to => 'admin/backyard/home#index'
  end

  namespace :admin do
    namespace :backyard do
      resources :home, only: %i[index]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
