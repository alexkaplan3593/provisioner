class Collection < ActiveRecord::Base
	has_and_belongs_to_many :tags
	has_many :products

	extend FriendlyId
  friendly_id :collection_name, use: :slugged

  def self.generate_and_set_products(tags)
    @products = []
    @collection_tags = []

  	tags.each do |tag|
  		tag = tag.downcase
    	@final_tag = Tag.where("LOWER(tag_name) = ?", tag).first
      
      if @final_tag.present?
      	@collection_tags << @final_tag.tag_name
      	@products += @final_tag.products
      	@products = @products.uniq  
      end

    end

    return @products

  end

end
