class DuesMailer < ApplicationMailer
  def dues_reminder
    @dues_house = params[:dues_house]
    addresses = params[:addresses]

    mail(to: addresses, subject: 'Madison Pointe Homeowners Association Dues Reminder')
  end
end
