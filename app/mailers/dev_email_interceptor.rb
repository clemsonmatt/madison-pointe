class DevEmailInterceptor
  def self.delivering_email(message)
    message.to = [
      ENV['SMTP_DEV_EMAIL']
    ]
  end
end
