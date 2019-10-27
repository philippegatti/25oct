class City < ApplicationRecord
	has_many :listings
	validates :name, presence: true, uniqueness: true
	validates :zip_code, presence: true, uniqueness: true
end
