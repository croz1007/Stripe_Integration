# require 'pry'
class ProfilesController < ApplicationController

  before_filter :get_stripe_customer

  def index
    @title = " - User Profile"
    @cards = @customer.sources.all(:object => "card")
  end

  def delete
    @title = " - Delete Card"
    @customer.sources.retrieve(params[:id]).delete
    redirect_to profiles_url, :notice => "Card Deleted"
  end

  def get_stripe_customer
    @customer ||= Stripe::Customer.retrieve(current_customer.stripe_id)
  end

end
