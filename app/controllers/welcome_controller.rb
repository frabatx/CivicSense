class WelcomeController < ApplicationController
  def welcome
  	@screams_today = Scream.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).count
  	@screams_so_far = Scream.count
  end
end
