require 'json'

class WebhooksController < ApplicationController

  def index
    @response = JSON.parse(params[:event_json])
  end

end
