## app = PartOne.new(path_to_file) 
## app.process 

require 'csv' 

class PartOne 
    attr_accessor :input
    attr_accessor :horizontal 
    attr_accessor :depth 
    attr_accessor :result 

	def initialize( name )
        @input = CSV.read( name ).flatten
        @horizontal = 0 
        @depth = 0 
    end

    def process 
        @input.each do |coord| 
            direction, count = coord.split(" ")
            count = count.to_i 


            case direction 
            when 'forward' 
                @horizontal += count 
            when 'down' 
                @depth += count 
            when 'up' 
                @depth -= count 
            end
        end

        @result = @depth * @horizontal
    end
end