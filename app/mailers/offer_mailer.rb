class OfferMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def offer(user)
    @user = user
    mail(to: @user.email, subject: 'Wow crazy offers!')
  end
end