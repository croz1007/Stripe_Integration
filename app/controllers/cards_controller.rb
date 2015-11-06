# require 'pry'
class CardsController < ApplicationController
  before_filter :get_stripe_customer

  def index
    @cards = @customer.sources.all(:object => "card")
  end

  def destroy
    @title = " - Delete a card"
    @subscriptions = @customer.subscriptions.all
    @message = "Cannot delete last card because you still have subscriptions."
    if @subscriptions.data.count <= 0
      @customer.sources.retrieve(params[:id]).delete
      @message = "Card Deleted"
    end
    sendToProfile(@message)
  end

  def edit
    @title = " - Edit Credit Card"
    @card = @customer.sources.retrieve(params[:id])
  end

  def update
    @title = "Update Credit Card"
    if params[:set_default]
      @customer.default_source = params[:id]
      @customer.save
      sendToProfile("Default Card Changed")
    else
      @card = @customer.sources.retrieve(params[:id])
      update_card_details
    end
  end

  def new
    @title = " - Add New Card"
    @no_card = params[:no_card_yet] unless nil
    @plan = params[:plan] unless nil
  end

  def create
    @title = "Create New Card"
    @token = params[:token]
    @source = @customer.sources.create(:source => @token)
    if !params[:no_card].blank?
      redirect_to new_subscription_path(:plan_id => params[:plan_id]) unless params[:plan_id].blank?
    else
      sendToProfile("New Card Added")
    end
  end

  protected

  def get_stripe_customer
    @customer ||= Stripe::Customer.retrieve(current_customer.stripe_id)
  end

  def sendToProfile (message)
    redirect_to profiles_url,  :notice => message
  end

  def update_card_details
    @card.address_city = params[:address_city] unless params[:address_city].blank?
    @card.address_country = params[:address_country] unless params[:address_country].blank?
    @card.address_line1 = params[:address_line1] unless params[:address_line1].blank?
    if !params[:address_line2].blank?
      @card.address_line2 = params[:address_line2]
    else
      @card.address_line2 = " "
    end
    @card.address_state = params[:address_state] unless params[:address_state].blank?
    @card.address_zip = params[:address_zip] unless params[:address_zip].blank?
    @card.exp_month = params[:exp_month]unless params[:exp_month].blank?
    @card.exp_year = params[:exp_year] unless params[:exp_year].blank?
    @card.name = params[:name] unless params[:name].blank?
    @card.save
    sendToProfile("Card Updated")
  end

end
