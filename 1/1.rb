# app = OneA.new('path_to_input_file')
# app.perform 

class OneA
	@INPUT = []
	def initialize(name)
		x = CSV.read(name).flatten!
		@INPUT = x.map(&:to_i)
	end 

	def perform


		counter = 0 
		@INPUT.each_cons(2) do |a,b|
			if b > a 
				counter += 1 
			end 
		end 
		return counter
	end
end 