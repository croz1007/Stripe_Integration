# require 'pry'

class CardsController < ApplicationController
  before_filter :get_stripe_customer

  def index
    @cards = @customer.sources.all(:object => "card")
  end

  def destroy
    redirect_to cards_url, :notice => "Needs implementation"
  end

  def edit
    # redirect_to cards_url, :notice => @card
    @card = @customer.sources.retrieve(params[:id])
  end

  def update
    @card = @customer.sources.retrieve(params[:id])

    if !params[:address_city].blank?
      @card.address_city = params[:address_city]
    end
    if !params[:address_country].blank?
      @card.address_country = params[:address_country]
    end
    if params[:address_line1].blank?
      @card.address_line1 = params[:address_line1]
    end
    if !params[:address_line2].blank?
      @card.address_line2 = params[:address_line2]
    end
    if !params[:address_state].blank?
      @card.address_state = params[:address_state]
    end
    if !params[:address_zip].blank?
      @card.address_zip = params[:address_zip]
    end
    if !params[:exp_month].blank?
      @card.exp_month = params[:exp_month]
    end
    if !params[:exp_year].blank?
      @card.exp_year = params[:exp_year]
    end
    if !params[:name].blank?
      @card.name = params[:name]
    end
    @card.save
    redirect_to profiles_url, :notice => "Card Updated"
  end

  def new
    redirect_to cards_url, :notice => "Needs implementation"
  end

  def delete
    # binding.pry
    # @customer.sources.retrieve(params[:id]).delete
    # redirect_to profiles_url, :notice => "Card Deleted"
  end

  protected

  def get_stripe_customer
    @customer ||= Stripe::Customer.retrieve(current_customer.stripe_id)
  end

end
