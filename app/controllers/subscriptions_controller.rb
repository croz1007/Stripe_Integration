# require 'pry'
class SubscriptionsController < ApplicationController

  before_filter :get_stripe_customer

  def index
  end

  def show
    @subscription = @customer.subscriptions.retrieve(params[:id])
  end

  def new
    @plan = Stripe::Plan.retrieve(params[:plan_id])
    @sources = @customer.sources.all
    if @sources.data.count <= 0
      redirect_to new_card_path(:no_card_yet => "true", :plan => @plan.id)
    end
  end

  def create
    @plan = Stripe::Plan.retrieve(params[:plan_id])
    @amount = @plan.amount
    if @customer.default_source.nil?
      redirect_to new_card_path(:no_card_yet => "true")
    else
      @customer.subscriptions.create(:plan => @plan.id)
      event_json = request.body.read #JSON.parse(request.body.read)
      redirect_to webhooks_path(:event_json => event_json)
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to subscriptions_path
  end

  def destroy
    @subscription = @customer.subscriptions.retrieve(params[:id])
    opts = {}
    opts = {:at_period_end => params[:at_period_end]} if params[:at_period_end]
    @refund_amount = calculate_refund_balance_due if params[:at_period_end]

    if @subscription.delete(opts)
      redirect_to profiles_url, notice: 'Subscription was successfully canceled.'
    end
  rescue Stripe::StripeError => e
    flash[:error] = e.message
    redirect_to subscriptions_path
  end

  protected

  def get_stripe_customer
    @customer ||= Stripe::Customer.retrieve(current_customer.stripe_id)
  end

  def get_remaining_days
    @end_date = DateTime.strptime(@subscription.current_period_end.to_s, '%s').to_date
    @cancel_date = DateTime.strptime(@subscription.canceled_at.to_s, '%s').to_date
    @days = (@end_date - @cancel_date).to_i
  end

  def calculate_refund_balance_due
    get_remaining_days

  end

  def get_most_recent_paid_subscription_charge

  end

end
