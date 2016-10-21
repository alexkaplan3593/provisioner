class Product < ActiveRecord::Base
	has_many :likes
	has_and_belongs_to_many :tags

	extend FriendlyId
  friendly_id :name, use: :slugged
	
	def self.get_amazon_info(product_id)

		require 'time'
		require 'uri'
		require 'openssl'
		require 'base64'

		passed_product_id = product_id

		params = {
		  "Service" => "AWSECommerceService",
		  "Operation" => "ItemLookup",
		  "AWSAccessKeyId" => "AKIAJPGDTJP63IHSIDHA",
		  "AssociateTag" => "kwiz-20",
		  "ItemId" => passed_product_id.to_str,
		  "IdType" => "ASIN",
		  "ResponseGroup" => "Images,ItemAttributes,Offers"
		}

		# Set current timestamp if not set
		params["Timestamp"] = Time.now.gmtime.iso8601 if !params.key?("Timestamp")

		# Generate the canonical query
		canonical_query_string = params.sort.collect do |key, value|
		  [URI.escape(key.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")), URI.escape(value.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))].join('=')
		end.join('&')

		# Generate the string to be signed
		string_to_sign = "GET\n#{ENV["ENDPOINT"]}\n#{ENV["REQUEST_URI"]}\n#{canonical_query_string}"

		# Generate the signature required by the Product Advertising API
		signature = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), ENV["AWS_SECRET_KEY"], string_to_sign)).strip()

		# Generate the signed URL
		request_url = "http://#{ENV["ENDPOINT"]}#{ENV["REQUEST_URI"]}?#{canonical_query_string}&Signature=#{URI.escape(signature, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))}"

		puts "Signed URL: \"#{request_url}\""

		response = HTTParty.get(request_url)
		return response
	end

end
