# app/jobs/test_job.rb
class TestJob < ActiveJob::Base
	require 'json'
	require 'httparty'

  def perform

  	@products = Product.all

  	@products.each do |product|
  		product_id = product.url.split('/dp/')[1]

  		if product_id.present?

	  		response = Product.get_amazon_info(product_id)
	  		json = response.parsed_response
	  		total_offers = json["ItemLookupResponse"]["Items"]["Item"]["Offers"]["TotalOffers"].to_i

	  		if total_offers >= 1
	  			price = json["ItemLookupResponse"]["Items"]["Item"]["Offers"]["Offer"]["OfferListing"]["Price"]["Amount"].to_i/100
	  			prime = json["ItemLookupResponse"]["Items"]["Item"]["Offers"]["Offer"]["OfferListing"]["IsEligibleForPrime"]
	  		else
	  			price = json["ItemLookupResponse"]["Items"]["Item"]["ItemAttributes"]["ListPrice"]["Amount"].to_i/100
	  		end

	  		## Convert to boolean for check
	  		prime == 1 ? prime = true : false

	  		if price != product.price
	  			product.price = price
	  			price_flag = 'update'
	  		else
	  			price_flag = 'no update'
	  		end

	  		if product.prime != prime
	  			product.prime = prime
	  			prime_flag = 'update'
	  		else
	  			prime_flag = 'no update'
	  		end

	  		product.save

	  		puts product_id + ' | price: ' + price_flag + ' | prime: ' + prime_flag
	  	else
	  		puts 'product does not match known URL structure'
	  	end
  	end

  end
end