# module Game
module Game
  # class Board
  class Board
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
      index_array = [index - @width - 1, index - @width, index - @width + 1,
                     index - 1, index + 1, index + @width - 1, index + @width,
                     index + @width + 1]
      index_array
    end

    def filter_norm(indices_array)
      indices_array.keep_if do |index|
        !index.nil? && index < @cell_count && index >= 0
      end
    end

    def filter_left_edge(indices_array)
      indices_array.keep_if do |index|
        !index.nil? &&
          index < @cell_count &&
          index >= 0 &&
          (index % @width) != (@width - 1)
      end
    end

    def filter_right_edge(indices_array)
      indices_array.keep_if do |index|
        !index.nil? &&
          index < @cell_count &&
          index >= 0 &&
          (index % @width).abs != 0
      end
    end

    def filter_neighbor_indices(indices_array, current)
      if (current % @width != 0) && (current % @width != @width - 1)
        filtered_indices = filter_norm(indices_array)
      elsif current % @width == 0
        filtered_indices = filter_left_edge(indices_array)
      else
        filtered_indices = filter_right_edge(indices_array)
      end
      filtered_indices.uniq
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
      final_cell_indices = filter_neighbor_indices(cell_indices, index)
      final_cells_array = finalize_neighbors(final_cell_indices)
      # p "final_cell_indices: #{final_cell_indices}"
      # p "final_cells_array: #{final_cells_array}"
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

    def print_board(board, iterator)
      rows = []
      row_counter = 0.upto(@length - 1)
      row_counter.each do |counter|
        row = board.slice(counter * @width, @width)
        rows.push(row)
      end
      p "Step: #{iterator}:"
      rows.each { |row_of_grid| p row_of_grid }
    end
  end
end

# tests
sample_game = Game::Board.new(3, 3)
counter = 1.upto(2)
counter.each { |iterator| sample_game.tick(iterator) }
