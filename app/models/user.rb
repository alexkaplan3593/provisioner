class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         has_many :products, through: :likes
         has_many :likes

         has_many :products, through: :collections
         has_many :collections

	def fullname
  	"#{first_name} #{last_name}"
	end

end
