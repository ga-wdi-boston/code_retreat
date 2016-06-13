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

    def initial_populate
      board_array.map! { |index| board_array[index] = rand.round }
    end

    def tick
      tmp = board_array
      tmp.map! { |index| tmp[index] = update(index, board_array) }
      board_array = tmp
      p board_array
    end

    # def neighbors(cell, width)
    #   values = board.slice((board.index(cell) - width - 1), 3).reduce(:+) +
    #   gameboard.slice((gameboard.index(cell) + width - 1), 3).reduce(:+) +
    #   gameboard.slice((gameboard.index(cell) - 1), 3).reduce(:+)
    #   values
    # end

    def build_neighbors_array(index)
      neighbors_array = []
      neighbors_array.push(@board_array[index - @width - 1])
      neighbors_array.push(@board_array[index - @width])
      neighbors_array.push(@board_array[index - @width + 1])
      neighbors_array.push(@board_array[index - 1])
      neighbors_array.push(@board_array[index + 1])
      neighbors_array.push(@board_array[index + @width - 1])
      neighbors_array.push(@board_array[index + @width])
      neighbors_array.push(@board_array[index + @width + 1])
      neighbors_array.compact!
    end

    def reduce_neighbors_array(neighbors_array)
      neighbors_array.reduce(:+)
    end

    def live_or_die(status, sum)
      if (status == 0 && sum == 3) || (status == 1 && (sum == 2 || sum == 3))
        1
      else
        0
      end
    end

    def update(index, array)
      live_or_die(array[index],
                  reduce_neighbors_array(build_neighbors_array(index)))
    end
  end
end

# tests
sample_game = Game::Board.new(4, 4)
p sample_game
sample_game.tick
sample_game.tick
