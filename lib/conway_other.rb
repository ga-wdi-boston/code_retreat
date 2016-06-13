# define module
module Game
  # gameboard class
  class Board
    attr_reader :count
    attr_accessor :board_array
    def initialize(length, width)
      @length = length
      @width = width
      @count = @length * @width
      @board_array = Array.new(16, 0)
      populate
    end

    def populate
      board_array.each do |index|
        rand = Random.new.rand(1...100)
        if rand <= 30
          board_array[index] = 1
        else
          board_array[index] = 0
        end
      end
    end

    def build_neighbors_array(array, index)
      neighbors_array = []
      neighbors_array.push(array[index - @width - 1])
      neighbors_array.push(array[index - @width])
      neighbors_array.push(array[index - @width + 1])
      neighbors_array.push(array[index - 1])
      neighbors_array.push(array[index + 1])
      neighbors_array.push(array[index + @width - 1])
      neighbors_array.push(array[index + @width])
      neighbors_array.push(array[index + @width + 1])
      neighbors_array.compact!
    end

    def create_sum(neighbors_array)
      neighbors_array.reduce(:+)
    end

    def live_or_die(status, sum)
      if (status == 0 && sum == 3) || (status == 1 && (sum == 2 || sum == 3))
        1
      else
        0
      end
    end
  end
end

my_game = Game::Board.new(4, 4)
p my_game
