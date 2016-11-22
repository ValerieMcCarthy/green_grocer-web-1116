def consolidate_cart(cart)
  new_cart = {}
  cart.each do |food_hash|
  	food_hash.each do |food, food_info|
  		if new_cart[food]
  			new_cart[food][:count] += 1
  		else
  			new_cart[food] = food_info
  			new_cart[food][:count] = 1	
		end
	end
end
new_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
  	food = coupon[:item]
  	if cart[food] && cart[food][:count]>=coupon[:num]
  		if cart["#{food} W/COUPON"]
  			cart["#{food} W/COUPON"][:count] += 1
  		else
  			cart["#{food} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
  			cart["#{food} W/COUPON"][:clearance] = cart[food][:clearance]
  		end
  		cart[food][:count] = cart[food][:count] - coupon[:num]
  	end
  end
  cart
end

def apply_clearance(cart)
  # discount every item on clearance by 20%
  cart.each do |food, info|
  	if info[:clearance] == true
  		info[:price] *= 0.8
  		info[:price] = info[:price].round(1)
  	end
  end
end


def checkout(cart, coupons)
	total_cart_cost = 0
  	consolidated = apply_coupons(consolidate_cart(cart), coupons)
  	clearance = apply_clearance(consolidated)
  	clearance.each do |food, info|
  		total_cart_cost += info[:price]*info[:count].round(2)
  	end
  	if total_cart_cost >100
  		total_cart_cost = total_cart_cost * 0.9
  	end
  	total_cart_cost
end
