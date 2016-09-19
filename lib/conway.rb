# you went back to the last commit
# i guess
#this is dumb as fuck. so what do i do now

# i dont kow how anyone could get any work done in this peripd
#back to what i was saying before we were interrupted by an airhorn

#the center cell is

# so the

#so we have to look at neighboring cells and determine if theyre alive or dead.
#theyre defined as neighbors in relation to the center cell. right?
# we should define reproduce, overpop, underpop and stay the same as methods
# in world right?

# agreed. We need a method for finding neighbors but idk how to do that yet
#i noticed if you draw a gameboard and number the tiles you can find commanalities
#between neighboring cells. but im not nearly good enough at math to figure it out

# each cell has a x number and a y number. subtracting from those numbers or add ing to them moves
#yeah exactly. but i dont know how to put those formulas in action

# think cells need a numerical xa nd y vale sas attributes
# so they would be numbered 0-79? or 1-80?
#and we'd use index of to find them?
# probably?
#im ready to speak words now

#not sure how to define these methods
# ive just been doing if/ esle stuff

#what does double pipes mean again

# or

class World
  def intialize (:tiles)
    @tiles = tiles
  end

  def overpop
    if Cell > 3 neighbors
      Cell == dead
  end

  def underpop
    if Cell < 2 neighbors
      Cell == dead
  end

  def reproduce
    if Cell == dead && neighbors == 2 || 3
      Cell == alive
  end

  def come_alive
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
