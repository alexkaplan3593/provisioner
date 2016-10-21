class Tag < ActiveRecord::Base
	has_and_belongs_to_many :products

	extend FriendlyId
  friendly_id :tag_name, use: :slugged
end
