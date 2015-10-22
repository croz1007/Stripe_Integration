raise "PUBLISHABLE_KEY or SECRET_KEY is not set" if ENV['PUBLISHABLE_KEY'].nil? ||  ENV['SECRET_KEY'].nil?

Rails.configuration.stripe = {
  :publishable_key => ENV['PUBLISHABLE_KEY'],
  :secret_key      => ENV['SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
