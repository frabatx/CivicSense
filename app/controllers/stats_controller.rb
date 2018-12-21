class StatsController < ApplicationController
  include ScreamsHelper

  def index
  	total_screams = Scream.count

    # Abort if no screams
    if total_screams != 0
    	status_count = Scream.group(:status).count

	    @category = Scream.group(:category).count.map do |category, count|
		  [category.name, count]
		end

	 	@status = Scream.group(:status).count.map do |status, value|
			[status_name(status), value]
		end

		  	
	  	@assign_time = (Scream.where(status: 2).map{|s| s.updated_at - s.created_at}.sum/total_screams / 1.day).to_i
	  	@close_time = (Scream.where(status: 3).map{|s| s.updated_at - s.created_at}.sum/total_screams / 1.day).to_i

	    @administration = Scream.group(:administration).count.map do |administration, count|
	      [administration.name, count]
	    end
    end

  end
end
