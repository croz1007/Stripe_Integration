class SubscriptionsController < ApplicationController

  before_filter :get_stripe_customer

  def index
  end

  def show
  end

  def create
    #this creates a card for the user
    @plan = Stripe::Plan.retrieve(params[:plan_id])
    @amount = @plan.amount
    @customer.sources.create(:source => params[:stripeToken])

    @customer.subscriptions.create(:plan => params[:plan_id])
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to subscriptions_path
  end

  def destroy 
    opts = {}
    opts = {:at_period_end => true} if params[:at_period_end]

    if @customer.subscriptions.retrieve(params[:id]).delete(opts)
      redirect_to subscriptions_url, notice: 'Subscription was successfully canceled.' 
    end
  rescue Stripe::StripeError => e
    flash[:error] = e.message
    redirect_to subscriptions_path
  end

  protected

  def get_stripe_customer
    @customer ||= Stripe::Customer.retrieve(current_customer.stripe_id)
  end

end