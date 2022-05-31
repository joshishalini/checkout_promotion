require_relative 'promotion'

class Checkout
  attr_reader :items

  def initialize
    @items = []
  end

  def scan(item)
    dup_item = find_item(item)
    if !dup_item.empty?
      dup_item.first[:quantity] += 1
    else
      @items << { data: item, quantity: 1 }
    end
  end

  def total
    @promotion = Promotion.new
    amount = count_total(@items)
    discount = @promotion.discount_on_amount(amount)
    final_price = (amount - discount).round(2)
  end

  private

  def find_item(item)
    @items.select {|i| i[:data][:code] == item[:code] }
  end

  def count_total(items)
    total = 0
    items.each do |item|
      discounted_price = @promotion.discount_on_item(item)
      price_per_item = if discounted_price
         discounted_price * item[:quantity]
      else
        item[:data][:price] * item[:quantity]
      end
      
      total = total + price_per_item
    end
    total
  end
end