module Yorchauth
  class UserMailer < ApplicationMailer
    default from: ENV['SENDGRID_EMAIL_VALID']
    layout 'mailer'

    def send_email_confirmation
      @user = params[:user]
      @url = "http://127.0.0.1:3000/email/confirmation/#{@user.token_id}"
      mail(to: @user.email, subject: 'My App - Email Confirmation')
    end
  end
end
