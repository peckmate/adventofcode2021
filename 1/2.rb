require 'csv' 

class OneB 
	attr_accessor :input 
	attr_accessor :window 
	attr_accessor :solution 

	def initialize(name)
		@input = CSV.read(name).flatten.map(&:to_i)
	end 

	def sliding_window 
		@window = @input.each_cons(3).map(&:sum)
	end 

	def perform
		counter = 0 
		@window.each_cons(2) do |a,b|
			if b > a 
				counter += 1 
			end 
		end 
		@solution = counter 
	end
end 