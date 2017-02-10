class Category < ActiveRecord::Base
	has_many :products
	extend FriendlyId
  friendly_id :category_name, use: :slugged
end
