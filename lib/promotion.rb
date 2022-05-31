# require 'bigdecimal'

class Promotion

  def discount_on_amount(total)
    @discount_amount = 0
    if total > 60
      @discount_amount = total * 0.1
    end

    @discount_amount
  end

  def discount_on_item(item_details)
    item = item_details[:data]
    quantity = item_details[:quantity]
    if item[:name] == "Lavender heart" && quantity >= 2
      8.50
    end
  end
end