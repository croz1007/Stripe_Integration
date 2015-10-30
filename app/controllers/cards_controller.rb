class CardsController < ApplicationController
  before_filter :get_stripe_customer

  def index
    @cards = @customer.sources.all(:object => "card")
  end

  def destroy
    @customer.sources.retrieve(params[:id]).delete
    sendToProfile("Card Deleted")
  end

  def edit
    # redirect_to cards_url, :notice => @card
    @card = @customer.sources.retrieve(params[:id])
  end

  def update
    @card = @customer.sources.retrieve(params[:id])
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

  def new

  end

  def create
    @token = params[:token]
    @customer.sources.create(:source => @token)
    sendToProfile("New Card Added")
  end

  protected

  def get_stripe_customer
    @customer ||= Stripe::Customer.retrieve(current_customer.stripe_id)
  end

  def sendToProfile (message)
    redirect_to profiles_url,  :notice => message
  end

end
