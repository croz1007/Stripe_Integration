class ChargesController < ApplicationController

  def new
  end

  def create
    # Amount in cents from plan
    @amount = 500

    # Customer must have card stored
    charge = Stripe::Charge.create(
      :customer => current_customer.stripe_id,
      :amount => @amount,
      :description => "TEST",
      :currency => 'usd'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end

end
