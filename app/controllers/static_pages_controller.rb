class StaticPagesController < ApplicationController

# This is homepage
  def welcome
    @title = " - Home"
    @plans = Stripe::Plan.all().sort { |a,b| a.name <=> b.name }
  end
end
