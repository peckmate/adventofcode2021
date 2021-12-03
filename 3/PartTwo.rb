require 'csv' 

class PartTwo 
    attr_accessor :input, :solution, :oxygen, :co2

    def initialize( path )
        @input = CSV.read( path ).flatten
        progressive_filter_find_least_common
        progressive_filter_find_most_common
        @solution = @oxgen * @co2
    end 

    def progressive_filter_find_most_common 
        position = 0 
        working_set = @input.dup

        while working_set.count > 1 
            bit_array = working_set.map{ |x| x.split("")[position] }
            bit_mcn = most_common_number_in( bit_array )
            working_set.reject! do |n|
                n.split("")[position] != bit_mcn
            end
            position += 1 
        end

        @oxgen = working_set.last.to_i( 2 )
    end

    def progressive_filter_find_least_common 
        position = 0 
        working_set = @input.dup
        
        while working_set.count > 1 
            bit_array = working_set.map{ |x| x.split("")[position] }
            bit_lcn = least_common_number_in( bit_array )

            working_set.reject! do |n|
                n.split("")[position] != bit_lcn
            end
            position += 1 
        end
        @co2 = working_set.last.to_i( 2 )
    end

    def most_common_number_in( array )
        x = array.each_with_object( Hash.new( 0 ) ){ |num, hash| hash[num] += 1 } 
        most_common = x.sort_by{ |key, value| value }.last[0]
        if x.map{ |k,v| v }.uniq.count == 1 
            return "1"
        else 
            most_common
        end
    end
    
    def least_common_number_in( array )
        x = array.each_with_object( Hash.new( 0 ) ){ |num, hash| hash[num] += 1 } 
        least_common = x.sort_by{ |key, value| value }.first[0]
        if x.map{ |k,v| v }.uniq.count == 1 
            return "0"
        else 
            least_common
        end
    end
end