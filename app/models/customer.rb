# require 'pry'

class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :register_stripe_customer

  def register_stripe_customer
    email = self.email

    Stripe::Customer.create(
      :email => email
    )
  end

end
