class SubscriptionsController < ApplicationController

  before_filter :get_stripe_customer, :get_plans

  def index
  end

  def show
  end

  def create
    @customer.subscriptions.create(:plan => params[:plan_id])
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to subscriptions_path
  end
  
  protected

  def get_stripe_customer
    @customer ||= Stripe::Customer.retrieve(current_customer.stripe_id)
  end

  def get_plans
    @plans ||= Stripe::Plan.all
  end
end


