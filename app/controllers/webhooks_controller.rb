require 'json'

class WebhooksController < ApplicationController

  def index
    @response = params[:event_json]
  end

end
