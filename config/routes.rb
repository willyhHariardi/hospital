Rails.application.routes.draw do
  devise_for  :admins, :path => 'sehatq/backyard',
              controllers: { registrations: "registrations" },
              :path_names => {
                :sign_in => "login",
                :sign_out => "logout",
              }

  root :to => "landing#index"

  get 'sehatq/backyard', to: "sehatq/backyard/home#index", as: 'home_dashboard'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  authenticated do
    root :to => 'sehatq/backyard/home#index'
  end

  namespace :sehatq do
    namespace :backyard do
      resources :home, only: %i[index]
      resources :admin
      resources :hospital
      resources :doctor
      resources :schedule_doctor
      resources :booking_doctor
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
