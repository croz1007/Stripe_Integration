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
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to subscriptions_path
  end

  def destroy
    opts = {}
    opts = {:at_period_end => true} if params[:at_period_end]

    if @customer.subscriptions.retrieve(params[:id]).delete(opts)
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

end
