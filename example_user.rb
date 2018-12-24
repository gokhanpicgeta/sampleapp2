class User 
	attr_accessor :firstName,:lastName,:email

	def initialize(attributes = {})
		@firstName = attributes[:firstName]
		@lastName = attributes[:lastName]
		@email = attributes[:email]
	end 

	def full_name
		"#{@firstName} #{@lastName}"
	end 

	def formatted_email
		full_name + " <#{@email}>"
	end 
end 