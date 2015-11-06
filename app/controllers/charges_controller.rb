class ChargesController < ApplicationController

  def new
  end

  def create
    @title = "Create New Charge"
    # Amount in cents from plan
    @amount = 500

    @customer = Stripe::Customer.retrieve(current_customer.stripe_id)

    #this creates a card for the user
    @customer.sources.create(:source => params[:stripeToken])

    charge = Stripe::Charge.create(
      :customer => @customer.id,
      :amount => @amount,
      :description => "TEST",
      :currency => 'usd'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end

end
