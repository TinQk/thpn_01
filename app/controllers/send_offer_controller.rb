class SendOfferController < ApplicationController

  def home_users
  end

  def create
    user = current_user
    user.send_email_offer
    redirect_to home_path
  end
end
