class WelcomeController < ApplicationController
  def welcome; end

  def letsencrypt
    render plain: ENV['LE_AUTH_RESPONSE']
  end
end
