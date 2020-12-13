require 'dxopal'
include DXOpal
class Control
  def initialize(position, size, move_speed, contact)
    @pos_x = position[0]
    @pos_y = position[1]
    @width = size[0]
    @height = size[1]
    @move_speed = move_speed
    @contact = contact
  end

  def figure
  end
end