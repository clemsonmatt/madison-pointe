Rails.application.routes.draw do
    resources :profile,
        :sessions

    # session
    get 'login', to: 'sessions#new', as: 'login'
    get 'logout', to: 'sessions#destroy', as: 'logout'

    # profile
    get 'profile-residents', to: 'profile#residents', as: 'profile_residents'
    delete 'profile-resident-delete/:id', to: 'profile#resident_delete', as: 'profile_resident_delete'

    get 'dashboard/index'
    root 'dashboard#index'

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
