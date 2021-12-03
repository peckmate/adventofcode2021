require 'csv' 


class PartOne 
    attr_accessor :input, :epsilon, :gamma, :solution 

    def initialize(path)
        @input = CSV.read( path ).flatten
        @epsilon = ""
        @gamma = ""
        
    end

    def perform 
        (0..11).to_a.each do |idx| 
            vertical_slice = input.map do |input| 
                input.split("")[idx]
            end
            
            slice_hash = vertical_slice.each_with_object(Hash.new(0)) do |num, hash| 
                hash[num] += 1 
            end
        
            least_common = slice_hash.sort_by{ |key, value| value }.first[0]
            most_common = slice_hash.sort_by{ |key, value| value }.last[0]
        
            @gamma += least_common.to_s 
            @epsilon += most_common.to_s 
        
        end

        @solution = @gamma.to_i(2) * @epsilon.to_i(2)
    end
end

### TODO: Convert the gamma and epsilon into integer somehow??? 