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
      if Input.key_down?(K_A)
        @v = 4
        if @field[@y][@x - 1] != 9
          @x -= 1
        end
      elsif Input.key_down?(K_D)
        @v = 8
        if @field[@y][@x + 1] != 9
          @x += 1
        end
      elsif Input.key_down?(K_W)
        @v = 12
        if @field[@y - 1][@x] != 9
          @y -= 1
        end
      elsif Input.key_down?(K_S)
        @v = 0
        if @field[@y + 1][@x] != 9
          @y += 1
        end
      end
    else @item_flag == 1
      if Input.key_push?(K_H) && @items[:heal] > 0
        @hp += 20
        @items[:heal] -= 1
      end
    end
    if Input.key_push?(K_E)
      if @item_flag == 0
        @item_flag = 1
      else
        @item_flag = 0
      end
    end
  end
end