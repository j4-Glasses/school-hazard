require 'dxopal'
include DXOpal
class Player
  def initialize(position, size, move_speed, contact)
    @pos_x = position[0]
    @pos_y = position[1]
    @width = size[0]
    @height = size[1]
    @speed = move_speed
    @contact = contact
  end

  def print
    p @pos_x
    p @pos_y
    p @width
    p @height
    p @speed
    p @contact
  end
end

player = Player.new([0, 10], [100, 200], 90, 3)
player.print