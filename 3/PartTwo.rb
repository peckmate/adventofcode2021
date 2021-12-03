require 'csv' 

class PartTwo 
    attr_accessor :input, :solution, :oxygen, :co2

    def initialize( path )
        @input = CSV.read( path ).flatten
        
        @oxygen = progressive_filter_commonality('most')
        @co2 = progressive_filter_commonality('least')
        @solution = ( @oxygen * @co2 )
    end 

    def progressive_filter_commonality(type)

        type = type.to_sym
        position = 0 
        working_set = @input.dup
    
        while working_set.count > 1 
            bit_array = working_set.map{ |x| x.split("")[position] }
            bit_cn = common_numbers( bit_array )[type]
    
            working_set.reject! do |n|
                n.split("")[position] != bit_cn
            end
            position += 1 
        end
    
        working_set.last.to_i( 2 )
    end

    def common_numbers( array ) 
        x = array.each_with_object( Hash.new( 0 ) ){ |num, hash| hash[num] += 1 } 
        least_common = x.sort_by{ |key, value| value }.first[0]
        most_common = x.sort_by{ |key, value| value }.last[0]
        if x.map{ |k,v| v }.uniq.count == 1 
            most_common = "1" 
            least_common = "0" 
        end
        { most: most_common, least: least_common }
    end
end