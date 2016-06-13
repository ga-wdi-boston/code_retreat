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
      board_array.map! { |index| board_array[index] = 1 }
    end

    def tick(iterator)
      tmp = board_array
      tmp.map! { |index| tmp[index] = update(index, board_array) }
      board_array = tmp
      p "Iteration: #{iterator}: #{board_array}"
    end

    def neighbors_count(index)
      @board_array.slice(index - @width - 1, 3).reduce(:+) +
        @board_array[index - 1] +
        @board_array[index + 1] +
        @board_array.slice(index + @width - 1, 3).reduce(:+)
    end

    # def build_neighbors_array(index)
    #   neighbors_array = [@board_array[index - @width - 1],
    #                      @board_array[index - @width],
    #                      @board_array[index - @width + 1],
    #                      @board_array[index - 1],
    #                      @board_array[index + 1],
    #                      @board_array[index + @width - 1],
    #                      @board_array[index + @width],
    #                      @board_array[index + @width + 1]]
    #   final_neighbors_array = neighbors_array.compact
    #   final_neighbors_array
    # end
    #
    # def reduce_neighbors_array(neighbors_array)
    #   neighbors_array.reduce(:+)
    # end

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
  end
end

# tests
sample_game = Game::Board.new(4, 4)
p sample_game
counter = 1.upto(10)
counter.each { |iterator| sample_game.tick(iterator) }
