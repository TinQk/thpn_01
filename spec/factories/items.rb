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
require 'factory_bot_rails'
require 'faker'

FactoryBot.define do
  factory :item do
    original_price      { Faker::Number.decimal(2) }

    trait :with_discount do
      has_discount { true }
      discount_percentage { Faker::Number.between(0, 100)}
    end

    trait :without_discount do
      has_discount { false }
    end

    factory :item_with_discount, traits: %i[with_discount]
    factory :item_without_discount, traits: %i[without_discount]
  end
end
