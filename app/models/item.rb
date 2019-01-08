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

class Item < ApplicationRecord
  def price
  	if has_discount == false || discount_percentage == nil
      original_price
	else
	  (original_price * (1 - discount_percentage.fdiv(100))).round(2)
	end
  end

  def self.average_price
  	sum = 0
  	if Item.count != 0
  	  Item.all.each {|i| sum += i.price}
  	  sum /= Item.count
  	else
  	  puts "There's no item in base"
  	  0
  	end
  end
end
