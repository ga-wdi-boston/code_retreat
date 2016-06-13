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
      @board_array.map! { |index| @board_array[index] = rand.round }
      print_board(@board_array, 0)
    end

    # def tick(iterator)
    #   tmp = @board_array
    #   tmp.map!.with_index do |_object, index|
    #     update(index)
    #   end
    #   @board_array = tmp
    #   print_board(@board_array, iterator)
    # end

    def tick(iterator)
      tmp = @board_array
      @board_array.each_index do |index|
        tmp[index] = update(index)
      end
      @board_array = tmp
      print_board(@board_array, iterator)
    end

    def top_count(index)
      @board_array.slice(index - @width - 1, 3).compact.reduce(:+)
    end

    def get_neighbors_indices(index)
      [index - @width - 1, index - @width, index - @width + 1,
       index - 1, index + 1,
       index + @width - 1, index + @width, index + @width + 1]
    end

    def filter_neighbor_indices(indices_array)
      indices_array.keep_if { |index| index > 0 && index <= @cell_count }
    end

    def finalize_neighbors(final_cell_indices)
      final_cells = []
      final_cell_indices.each do |index|
        final_cells.push(@board_array[index])
      end
      final_cells
    end

    def neighbors_count(index)
      cell_indices = get_neighbors_indices(index)
      final_cell_indices = filter_neighbor_indices(cell_indices)
      final_cells_array = finalize_neighbors(final_cell_indices)
      final_cells_array.compact.reduce(:+)
    end

    def live_or_die(status, sum)
      if (status == 0 && sum == 3) || (status == 1 && (sum == 2 || sum == 3))
        1
      else
        0
      end
    end

    def update(index)
      live_or_die(@board_array[index], neighbors_count(index))
    end

    def print_board(board_array, iterator)
      rows = []
      row_counter = 0.upto(length - 1)
      row_counter.each do |counter|
        row = board_array.slice(counter, width)
        rows.push(row)
      end
      p "Step: #{iterator}:"
      rows.each { |row_of_grid| p row_of_grid }
    end
  end
end

# tests
sample_game = Game::Board.new(4, 4)
counter = 1.upto(4)
counter.each { |iterator| sample_game.tick(iterator) }
