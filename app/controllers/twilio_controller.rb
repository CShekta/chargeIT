class TwilioController < ApplicationController

  skip_before_action :verify_authenticity_token

  ACCOUNT_ID = ENV["TWILIO_ACCOUNT_SID"]
  AUTH_TOKEN = ENV["TWILIO_AUTH_TOKEN"]

  def notify
    client = Twilio::REST::Client.new ACCOUNT_ID, AUTH_TOKEN
    message = client.messages.create from: '+19545049805', to: '+19543288152', body: 'Learning to send SMS you are.'
    render plain: message.status
  end
end
