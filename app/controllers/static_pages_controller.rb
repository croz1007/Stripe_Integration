class StaticPagesController < ApplicationController

  def welcome
    #TODO: fill out things in the /views/static_pages/welcome
    @title = " - Home"
    @plans = Stripe::Plan.all().sort { |a,b| a.name <=> b.name }
  end
end
