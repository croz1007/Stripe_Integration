module ApplicationHelper

  def centsToDollars (amount)
    number_to_currency(amount/100.0, format: "%u%n")
  end

end
