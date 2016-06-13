# module Game
module Game
  # class Board
  class Board
    attr_accessor :board_array
    attr_reader :width, :length, :cell_count

    def initialize(length, width)
      @width = width
      @length = length
      @cell_count = width * length
      @board_array = Array.new(@cell_count, 0)
      initial_populate
    end

    def initial_populate
      board_array.map! { |index| board_array[index] = rand.round }
      print_board(board_array, 0)
    end

    def tick(iterator)
      tmp = board_array
      tmp.map! { |index| tmp[index] = update(index, board_array) }
      board_array = tmp
      print_board(board_array, iterator)
    end

    def neighbors_count(index)
      @board_array.slice(index - @width - 1, 3).reduce(:+) +
        @board_array[index - 1] +
        @board_array[index + 1] +
        @board_array.slice(index + @width - 1, 3).reduce(:+)
    end

    def live_or_die(status, sum)
      if (status == 0 && sum == 3) || (status == 1 && (sum == 2 || sum == 3))
        1
      else
        0
      end
    end

    def update(index, array)
      live_or_die(array[index], neighbors_count(index))
    end

    def print_board(board_array, iterator)
      rows = []
      row_counter = 0.upto(length - 1)
      row_counter.each do |counter|
        row = board_array.slice(counter, width)
        rows.push(row)
      end
      p iterator
      rows.each { |row_of_grid| p row_of_grid }
    end
  end
end

# tests
sample_game = Game::Board.new(4, 4)
p sample_game
counter = 1.upto(4)
counter.each { |iterator| sample_game.tick(iterator) }
