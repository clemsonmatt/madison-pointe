Rails.application.routes.draw do
  resources :profile,
            :sessions,
            :security,
            :directory,
            :resources

  namespace :manage do
    resources :people,
              :dues
  end

  # session
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  # profile
  get 'profile-residents', to: 'profile#residents', as: 'profile_residents'
  delete 'profile-resident-delete/:id', to: 'profile#resident_delete', as: 'profile_resident_delete'

  # directory
  get 'all-people', to: 'directory#all', as: 'directory_all'

  # manage people
  get 'manage/people/:id/residents', to: 'manage/people#residents', as: 'manage_person_residents'
  get 'manage/people/:id/verify-account', to: 'manage/people#verify_account', as: 'manage_person_verify_account'

  # manage dues
  get 'manage/dues/:id/dues-paid', to: 'manage/dues#dues_paid', as: 'manage_dues_house_paid'
  get 'manage/dues/:id/dues-not-paid', to: 'manage/dues#dues_not_paid', as: 'manage_dues_house_not_paid'

  get 'verify-account/:verification_token', to: 'security#verify_email', as: 'security_verify_email'

  get 'dashboard/index'
  root 'dashboard#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
