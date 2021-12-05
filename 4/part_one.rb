
#25023
class PartOne
  attr_accessor :raw_input, :bingo_numbers, :cards, :solution

  def initialize( path )
    @raw_input = File.read( path )
    working_input = @raw_input.dup.split( /\n\n/ )

    # pull off the bingo numbers
    @bingo_numbers = working_input.shift( 1 ).last.split(",").map(&:to_i)

    # create a BingoCard for each of the boards
    @cards = working_input.map { |bd| BingoCard.new( bd ) }

    @victory = false
    @bingo_numbers.each do |number|
      next unless @victory == false
      @cards.each do |card|
        card.call(number)
        if card.bingo == true
          @victory = true
        end
      end
    end

    vc = @cards.find(&:bingo)
    @solution = vc.victory_number * vc.sum_unstamped_numbers
  end
end

class BingoCard
  attr_accessor :board_data, :hash, :bingo, :victory_number

  def initialize( board_data )
    @bingo = false
    @board_data = board_data
    @rows = @board_data.split( /\n/ )
    @hash = {}
    @rows.each_with_index do |row, idx|
      numbers = row.split(" ").map(&:to_i)
      @hash[idx] = Hash.new unless @hash[idx].class == Hash
      numbers.each do |n|
        @hash[idx][n] = Hash.new unless @hash[idx][n].class == Hash
        @hash[idx][n] = 0
      end
    end
  end

  def card_has_number?( number )
    return 0 unless @hash[0][number].nil?
    return 1 unless @hash[1][number].nil?
    return 2 unless @hash[2][number].nil?
    return 3 unless @hash[3][number].nil?
    return 4 unless @hash[4][number].nil?

    return 100
  end

  def call( number )
    x = card_has_number?( number )
    return false if x == 100

    @hash[x][number] = 1
    if row_win? || column_win?
      @bingo = true
      @victory_number = number
    end
  end

  ## Check to see if any row is a win
  def row_win?
    return true if @hash[0].all? { |_, v| v == 1 }
    return true if @hash[1].all? { |_, v| v == 1 }
    return true if @hash[2].all? { |_, v| v == 1 }
    return true if @hash[3].all? { |_, v| v == 1 }
    return true if @hash[4].all? { |_, v| v == 1 }

    return false
  end

  ## Check the same index of each of the hashes to see if there is a
  ## win across the vertical
  def column_win?
    y = 0
    x = false
    while x == false && y < 5

      b = @hash[0][@hash[0].keys[y]]
      i = @hash[1][@hash[1].keys[y]]
      n = @hash[2][@hash[2].keys[y]]
      g = @hash[3][@hash[3].keys[y]]
      o = @hash[4][@hash[4].keys[y]]

      if [b, i, n, g, o].all? { |z| z == 1 }
        x = true
      else
        y += 1
      end
    end
    x
  end

  def sum_unstamped_numbers
    sum = 0

    @hash[0].each { |k, v| sum += k if v.zero? }
    @hash[1].each { |k, v| sum += k if v.zero? }
    @hash[2].each { |k, v| sum += k if v.zero? }
    @hash[3].each { |k, v| sum += k if v.zero? }
    @hash[4].each { |k, v| sum += k if v.zero? }

    sum
  end
end


#
# data = {
#   row_one: { 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0 },
#   row_two: { 6 => 0, 7 => 0, 8 => 0, 9 => 0, 10 => 0 },
#   row_three: { 11 => 0, 12 => 0, 13 => 0, 14 => 0, 15 => 0 },
#   row_four: { 16 => 0, 17 => 0, 18 => 0, 19 => 0, 20 => 0 },
#   row_five: { 21 => 0, 22 => 0, 23 => 0, 24 => 0, 25 => 0 }
# }
#
