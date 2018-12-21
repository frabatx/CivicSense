module ScreamsHelper
	def status_name(value)
		case value
		when 1
			"New"
		when 2
			"Assigned"
		when 3
			"Closed"
		end
	end
end
