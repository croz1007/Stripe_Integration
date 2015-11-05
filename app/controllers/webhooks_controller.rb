require 'json'

class WebhooksController < ApplicationController

  def index
    @response = JSON.parse({"response": params[:event_json]})
  end

end
