## app = PartTwo.new(path_to_file) 
## app.process 


require 'csv' 

class PartTwo 
    attr_accessor :input, :aim, :depth, :horizontal, :result 

    def initialize( name )
        @input = CSV.read( name ).flatten
        @horizontal = 0 
        @depth = 0 
        @aim = 0
    end

    def process 
        @input.each do |coord| 
            direction, count = coord.split(" ")
            count = count.to_i 


            case direction 
            when 'forward' 
                @horizontal += count 
                @depth += ( @aim * count)
            when 'down' 
                @aim += count 
            when 'up' 
                @aim -= count 
            end
            @result = @depth * @horizontal
        end
    end
end