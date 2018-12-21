class Scream < ApplicationRecord
 	belongs_to :category
 	belongs_to :solver, optional: true
 	belongs_to :administration
 	has_many_attached :uploads

 	before_update :set_status
 	before_create :set_id

 	scope :from_date, -> (date) { where('DATE(created_at) >= ?', date) }
 	scope :to_date, -> (date) { where('DATE(created_at) <= ?', date) }

 	validate :correct_document_mime_type
 	validate :has_location
 	validates :screamer_email, allow_blank: true, format: { with: Devise.email_regexp, message: "is not a valid email address" }

	def self.with_status(status)
 		case status
        when '1'
         	where('status == 1')
        when '2'
        	where('status == 2')
        when '3'
        	where('status == 3')
        when '12'
        	where('status == 1 or status == 2')
        else
        	all
        end
 	end

 	private

 	def set_id
 		token = ""
 		loop do
	    	token = SecureRandom.hex(6)
	    	break token unless self.class.exists?(id: token)
	  	end
	  	self.id = token
 	end

 	def set_status
 		if self.solver == nil
 			self.status = 1
 		elsif !self.solver != nil && self.status_was == 1
 			self.status = 2
 		end
 	end

 	def correct_document_mime_type
	    if self.uploads.attached? 
	    	uploads.each do |upload|
	    		if !upload.content_type.starts_with?('image/')
					errors.add(:attachments, 'can contain only images!')
	    		end
	    	end
	    end
  	end

  	def has_location
  		if !self.longitude or self.longitude == 0
  			errors.add(:location, "has not been allowed on this device. Please enable GPS location and retry.")
  		end 
  	end

end
