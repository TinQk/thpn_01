# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id                  :bigint(8)        not null, primary key
#  original_price      :float            not null
#  has_discount        :boolean          default(FALSE)
#  discount_percentage :integer          default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Model instantiation' do
    subject(:new_item) { described_class.new }

    describe 'Database' do
      it { is_expected.to have_db_column(:id).of_type(:integer) }
      it { is_expected.to have_db_column(:original_price).of_type(:float).with_options(null: false) }
      it { is_expected.to have_db_column(:has_discount).of_type(:boolean).with_options(default: false) }
      it { is_expected.to have_db_column(:discount_percentage).of_type(:integer).with_options(default: 0) }
      it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
      it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    end
  end

  describe 'Price' do
    context 'when the item has a discount' do
      let(:item) { build(:item_with_discount, original_price: 100.00, discount_percentage: 20) }

      it { expect(item.price).to eq(80.00) }
      it { expect(item.has_discount).to eq(true) }
    end

    context 'when the item has a random (0-100) discount' do
      let(:item) { build(:item_with_discount) }

      it { expect(item.price).to eq((item.original_price * (1 - item.discount_percentage.fdiv(100))).round(2)) }
      it { expect(item.has_discount).to eq(true) }
    end

    context 'when the item has no discount' do
      let(:item) { build(:item_without_discount) }

      it { expect(item.price).to eq(item.original_price) }
      it { expect(item.has_discount).to eq(false) }
    end
  end

  describe 'Average Price' do
    context 'with 50 items with discount' do
      before do
        create_list(:item_with_discount, 50, original_price: 100, discount_percentage: 20 )
      end

      it { expect(Item.average_price).to eq(80) }
    end

    context 'with no item in base' do
      before do
        create_list(:item_with_discount, 0)
      end

      it { expect(Item.average_price).to eq(nil) }
    end
  end
end
