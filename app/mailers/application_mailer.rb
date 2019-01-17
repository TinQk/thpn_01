# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'charles.belpois@gmail.com'
  layout 'mailer'
end
