# frozen_string_literal: true

class HomeController < ApplicationController
  def landing_page
    @user = current_user

  end
end
