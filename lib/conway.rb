
class World
  def intialize (:tiles)
    @tiles = tiles
  end
end



class Cells
  def initialize
    @state = false
    @neighbors = 0
  end

  def change_state
    if self.state == 'false',
      self.state = 'true',
    else
      self.state = 'false'
end
