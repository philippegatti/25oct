class Listing < ApplicationRecord
	belongs_to :city
	belongs_to :admin, class_name: "User"
	has_many :reservations
	validates :available_beds, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0}
	validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0}
	validates :description, presence: true, length: {minimum: 140}
	validates :welcome_message, presence: true

  	def overlaping_reservation? (starttime, endtime)
  		return self.reservations.count{|item| (starttime.to_date == item.start_date.to_date) || ((starttime.to_date < item.start_date.to_date) && (endtime.to_date > item.start_date.to_date)) || ((starttime.to_date < item.end_date.to_date) && (endtime.to_date >= item.end_date.to_date))} > 0
  	end


end
