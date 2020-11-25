Rails.application.routes.draw do
  resources :profile,
            :sessions,
            :security,
            :directory,
            :resources

  namespace :manage do
    resources :people
    resources :dues do
      collection do
        get 'reminder-notification', to: 'reminder_notification', as: 'reminder_notification'
      end
    end
  end

  # session
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  # security
  get 'verify-account/:verification_token', to: 'security#verify_email', as: 'security_verify_email'
  get 'forgot-password', to: 'security#password_forgot', as: 'security_forgot_password'
  post 'forgot-password', to: 'security#password_forgot_reset', as: 'security_forgot_password_reset'
  get 'reset-password/:reset_password_token', to: 'security#password_reset', as: 'security_reset_password'
  post 'reset-password/:reset_password_token', to: 'security#update_password', as: 'security_update_password'

  # profile
  post 'profile-pay-dues', to: 'profile#pay_dues', as: 'profile_pay_dues'
  get 'profile-residents', to: 'profile#residents', as: 'profile_residents'
  delete 'profile-resident-delete/:id', to: 'profile#resident_delete', as: 'profile_resident_delete'
  get 'update-settings/:setting', to: 'profile#update_settings', as: 'profile_update_settings'

  # manage people
  get 'manage/people/:id/residents', to: 'manage/people#residents', as: 'manage_person_residents'
  get 'manage/people/:id/verify-account', to: 'manage/people#verify_account', as: 'manage_person_verify_account'
  get 'manage/people/:id/toggle-permission/:permission', to: 'manage/people#toggle_permission', as: 'manage_person_toggle_permission'

  # manage dues
  get 'manage/dues/:year/:id/dues-paid', to: 'manage/dues#dues_paid', as: 'manage_dues_house_paid'
  get 'manage/dues/:year/:id/dues-not-paid', to: 'manage/dues#dues_not_paid', as: 'manage_dues_house_not_paid'
  get 'manage/dues/:year/year', to: 'manage/dues#dues_by_year', as: 'manage_dues_by_year'

  get 'dashboard/index'
  root 'dashboard#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
