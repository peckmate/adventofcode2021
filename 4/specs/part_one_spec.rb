require 'rspec'
require './part_one'

RSpec.describe PartOne do

  it 'can test!' do
    expect(described_class).to eq(PartOne)
  end


end


RSpec.describe BingoCard do
  let(:sample_board_data) do
    "35 31 86 36 52\n18 50 79 60 67\n98  3 51 46 25\n 4 61 55 87 70\n94 39 68 27 14"
  end

  it 'can test!' do
    expect(described_class).to eq(BingoCard)
  end

  it 'can do other things' do
    bingo_card = described_class.new( sample_board_data )
    require 'pry' ; binding.pry
  end
end
