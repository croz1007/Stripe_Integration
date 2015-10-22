# require 'pry'

class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :register_stripe_customer

  validates_presence_of :stripe_id, :on => :save

  def register_stripe_customer
    email = self.email

    customer = Stripe::Customer.create(
      :email => email
    )
    self.stripe_id = customer.id
  end

end
