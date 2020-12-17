require 'dxopal'
include DXOpal
class Player
  attr_reader :x, :y, :hp, :st_flag, :items, :v, :items_flag, :get_item
  def initialize(field, position, hp = 100, items = {heal: 0, key: 0, usb: 0})
    @field = field
    @x = position[0]
    @y = position[1]
    @v = 0
    @hp = hp
    @items = items
    @items_flag = 0
    @st_flag = 0
    @get_item = nil
  end
  def control
    #items_flag = 0
    items_hist = @items
    sleep(0.1)
    if @st_flag == 0
      if Input.key_down?(K_A)
        @v = 4
        if @field[@y][@x - 1] == 0
          @x -= 1
        end
      elsif Input.key_down?(K_D)
        @v = 8
        if @field[@y][@x + 1] == 0
          @x += 1
        end
      elsif Input.key_down?(K_W)
        @v = 12
        if @field[@y - 1][@x] == 0
          @y -= 1
        end
      elsif Input.key_down?(K_S)
        @v = 0
        if @field[@y + 1][@x] == 0
          @y += 1
        end
      end
      if Input.key_push?(K_Q)
        case @v
        when 4
          case @field[@y][@x - 1]
          when 5
            @items[:heal] += 1
            @field[@y][@x - 1] = 9
          when 6
            @items[:key] += 1
            @field[@y][@x - 1] = 9
          when 7
            @items[:usb] += 1
            @field[@y][@x - 1] = 9
          end
        when 8
          case @field[@y][@x + 1]
          when 5
            @items[:heal] += 1
            @field[@y][@x + 1] = 9
          when 6
            @items[:key] += 1
            @field[@y][@x + 1] = 9
          when 7
            @items[:usb] += 1
            @field[@y][@x + 1] = 9
          end
        when 12
          case @field[@y - 1][@x]
          when 5
            @items[:heal] += 1
            @field[@y - 1][@x] = 9
          when 6
            @items[:key] += 1
            @field[@y - 1][@x] = 9
          when 7
            @items[:usb] += 1
            @field[@y - 1][@x] = 9
          end
        when 0
          case @field[@y + 1][@x]
          when 5
            @items[:heal] += 1
            @field[@y + 1][@x] = 9
          when 6
            @items[:key] += 1
            @field[@y + 1][@x] = 9
          when 7
            @items[:usb] += 1
            @field[@y + 1][@x] = 9
          end
        end
      end
    else @st_flag == 1
      if Input.key_push?(K_H) && @items[:heal] > 0
        @hp += 20
        @items[:heal] -= 1
      end
    end
    if Input.key_push?(K_E)
      if @st_flag == 0
        @st_flag = 1
      else
        @st_flag = 0
      end
    end
    if @items[:heal] != items_hist[:heal]
      @items_flag = 1
      @get_item = :heal
    elsif @items[:key] != items_hist[:key]
      @items_flag = 1
      @get_item = :key
    elsif @items[:usb] != items_hist[:usb]
      @items_flag = 1
      @get_item = :usb
    else
      @get_item = nil
    end
    @field
  end
end