class StaticPagesController < ApplicationController

  def welcome
    @title = " - Home"
    @plans = Stripe::Plan.all().sort { |a,b| a.name <=> b.name }
  end
end
