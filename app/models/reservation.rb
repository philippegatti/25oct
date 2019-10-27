class Reservation < ApplicationRecord
	belongs_to :listing
	belongs_to :invitee, class_name: "User"
	validates :start_date, :presence => { :message => "must be a valid date/time" }
    validates :end_date, :presence => {:message => "must be a valid date/time"}
	validate :start_must_be_before_end_date
	validate :overlaping_reservation?


	def start_must_be_before_end_date
		if start_date.to_date >= end_date.to_date || (end_date.to_date - start_date.to_date).to_i > 30
			errors.add(:end_date, "can't be before start_date")
		end
	end

	def overlaping_reservation?
		if Listing.find(listing_id).overlaping_reservation?(start_date,end_date) == true
			errors.add(:listing_id, "can't overlap reservation")
		end
	end	

  	def duration
  		end_date.to_i - start_date.to_i
  	end

end
