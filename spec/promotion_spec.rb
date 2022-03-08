require_relative '../lib/checkout'
require 'pry'

RSpec.describe Promotion do
  subject(:promotion) { described_class.new }


  let(:item_1) do 
    {code: '001', name: 'Lavender heart', price: 9.25}
  end
  let(:item_2) do 
    {code: '002', name: 'Personalised cufflinks', price:45.00} 
  end

  describe "#discount_on_amount" do

    before do
      promotion
    end

    context "When total is greater than 60" do
      it "It will give 10% discount " do
        expect(promotion.discount_on_amount(70)).to eq(7)
      end
    end

    context "When total is less than 60" do
      it "It will give No discount " do
        expect(promotion.discount_on_amount(50)).to eq(0)
      end
    end
  end

  describe "#discount_on_item" do

    before do
      promotion
    end

    context "When Item is Lavender heart" do
      context "When Quantity is 3" do
        let (:item_details_1) do
        { 
          data: item_1, quantity: 3 
        }
        end

        it "It drop the price" do
          expect(promotion.discount_on_item(item_details_1)).to eq(8.50)
        end
      end

      context "When Quantity is 1" do
        let (:item_details_1) do
        { 
          data: item_1, quantity: 1
        }
        end

        it "Wont drop the price" do
          expect(promotion.discount_on_item(item_details_1)).to eq(nil)
        end
      end
    end

    context "When Item is not Lavender heart" do
      context "When Quantity is 3" do
        let (:item_details_2) do
        { 
          data: item_2, quantity: 3 
        }
        end

        it "Wont drop the price" do
          expect(promotion.discount_on_item(item_details_2)).to eq(nil)
        end
      end
    end
  end
end