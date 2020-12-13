require 'dxopal'
include DXOpal
class Player
  attr_reader :x, :y, :hp
  def initialize(field, position, vector = 1, hp = 100, items = [])
    @field = field
    @x = position[0]
    @y = position[1]
    @hp = hp
    @items = items
  end
  def control
    sleep(0.1)
    if Input.key_down?(K_LEFT) && @field[@y][@x - 1] != 9
      @x -= 1
    elsif Input.key_down?(K_RIGHT) && @field[@y][@x + 1] != 9
      @x += 1
    elsif Input.key_down?(K_UP) && @field[@y - 1][@x] != 9
      @y -= 1
    elsif Input.key_down?(K_DOWN) && @field[@y + 1][@x] != 9
      @y += 1
    end
    if Input.key_down?(K_U)
      @hp += 20
    end
  end
end