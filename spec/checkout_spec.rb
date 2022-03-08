require_relative '../lib/checkout'
require 'pry'

RSpec.describe Checkout do
	subject(:checkout) { described_class.new }

	let(:item_1) do 
		{code: '001', name: 'Lavender heart', price: 9.25}
	end
	let(:item_2) do 
		{code: '002', name: 'Personalised cufflinks', price: 45.00} 
	end
	let(:item_3) do 
		{code: '003', name: 'Kids T-shirt', price: 19.95} 
	end

	describe "#scan" do

		before do
			checkout
		end

		it "It scan an item" do
			checkout.scan(item_1)
			expect(checkout.items.count).to eq(1)
		end

		it "It scan multiple items" do
			checkout.scan(item_1)
			checkout.scan(item_2)
			checkout.scan(item_2)
			expect(checkout.items.count).to eq(2)
		end
	end

	describe "#total" do
		before do
			checkout
		end

		context "When Basket: 001,002,003" do
			before do
				checkout.scan(item_1)
				checkout.scan(item_2)
				checkout.scan(item_3)
			end

			it "Total price expected: £66.78" do
				expect(checkout.total).to eq(66.78)
			end
		end 

		context "When Basket: 001,003,001" do
			before do
				checkout.scan(item_1)
				checkout.scan(item_3)
				checkout.scan(item_1)
			end

			it "Total price expected: £66.78" do
				expect(checkout.total).to eq(36.95)
			end
		end 

		context "When Basket: 001,002,001,003" do
			before do
				checkout.scan(item_1)
				checkout.scan(item_2)
				checkout.scan(item_1)
				checkout.scan(item_3)
			end

			it "Total price expected: £66.78" do
				expect(checkout.total).to eq(73.76)
			end
		end 
	end
end