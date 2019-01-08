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
  	
  	if self.has_discount == false
      self.original_price
	else
	  self.original_price - (self.discount_percentage/self.original_price * 100)
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
