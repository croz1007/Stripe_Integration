require 'json'

class WebhooksController < ApplicationController

  def index
    @response = params[:event_json]
  end

  def create
    Stripe.api_key = ENV['SECRET_KEY']
    event_json = request.body.read #JSON.parse(request.body.read)
    @response = event_json
  end
  
end
