class PartTwo
  attr_accessor :input, :solution

  def initialize( path )
      @input = CSV.read( path ).flatten
  end
end
