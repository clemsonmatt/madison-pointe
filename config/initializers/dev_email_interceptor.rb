ActionMailer::Base.register_interceptor(DevEmailInterceptor) if Rails.env.development?
