class ProfilesController < ApplicationController

  before_filter :get_stripe_customer

  def index
    @cards = @customer.sources.all(:object => "card")
  end

  def get_stripe_customer
    @customer ||= Stripe::Customer.retrieve(current_customer.stripe_id)
  end

end
