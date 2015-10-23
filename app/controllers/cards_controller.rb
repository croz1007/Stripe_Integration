class CardsController < ApplicationController
  before_filter :get_stripe_customer

  def index
    @cards = @customer.sources.all(:object => "card") 
  end

  def destroy
    redirect_to cards_url, :notice => "Needs implementation"
  end

  def edit
    redirect_to cards_url, :notice => "Needs implementation"
  end

  def update
    redirect_to cards_url, :notice => "Needs implementation"
  end

  protected

  def get_stripe_customer
    @customer ||= Stripe::Customer.retrieve(current_customer.stripe_id)
  end

end
