class WebhooksController < ApplicationController

  def index
    event_json = JSON.parse(request.body.read)
    @response = event_json
  end

end
