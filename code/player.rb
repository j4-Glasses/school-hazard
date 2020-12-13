require 'dxopal'
include DXOpal
class Player
  attr_reader :x, :y, :hp, :item_flag, :items, :v
  def initialize(field, position, hp = 100, items = {heal: 10, key: 1, usb: 3})
    @field = field
    @x = position[0]
    @y = position[1]
    @v = 0
    @hp = hp
    @items = items
    @item_flag = 0
  end
  def control
    sleep(0.1)
    if @item_flag == 0
      if Input.key_down?(K_LEFT) && @field[@y][@x - 1] != 9
        @x -= 1
        @v = 4
      elsif Input.key_down?(K_RIGHT) && @field[@y][@x + 1] != 9
        @x += 1
        @v = 8
      elsif Input.key_down?(K_UP) && @field[@y - 1][@x] != 9
        @y -= 1
        @v = 12
      elsif Input.key_down?(K_DOWN) && @field[@y + 1][@x] != 9
        @y += 1
        @v = 0
      end
    else @item_flag == 1
      if Input.key_push?(K_U) && @items[:heal] > 0
        @hp += 20
        @items[:heal] -= 1
      end
    end
    if Input.key_push?(K_I)
      if @item_flag == 0
        @item_flag = 1
      else
        @item_flag = 0
      end
    end
  end
end