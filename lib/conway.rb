# module Game
module Game
  # class Board
  class Board
    attr_accessor :board_array
    def initialize(length, width)
      @width = width
      @length = length
      @cell_count = width * length
      @board_array = Array.new(@cell_count, 0)
      initial_populate
    end

    def update(index, board_array)
      p index
      p board_array
      rand.round
    end

    def initial_populate
      board_array.map! { |index| board_array[index] = rand.round }
    end

    def tick
      tmp = board_array
      tmp.map { |index| tmp[index] = update(index, board_array) }
      board_array = tmp
      p board_array
    end
  end
end

# tests
sample_game = Game::Board.new(4, 4)
p sample_game
sample_game.tick
