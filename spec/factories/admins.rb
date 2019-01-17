# frozen_string_literal: true

FactoryBot.define do
  factory :admin do
  	email { "bob@bob.lol" }
  	password { "azerty" }
  	password_confirmation { "azerty" }
  end
end
