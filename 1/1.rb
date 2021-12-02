require 'csv' 

class OneA
	attr_accessor :input 
	attr_accessor :solution 

	def initialize(name)
		x = CSV.read(name).flatten!
		@input = x.map(&:to_i)
	end 

	def perform


		counter = 0 
		@input.each_cons(2) do |a,b|
			if b > a 
				counter += 1 
			end 
		end 
		@solution = counter 
	end
end 