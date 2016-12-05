class Collection < ActiveRecord::Base
	has_and_belongs_to_many :tags
	has_many :products

	extend FriendlyId
  friendly_id :collection_name, use: :slugged

  def get_products

  end

end
