require 'dxopal'
include DXOpal

Sound.register(:heal, '../sounds/heal.mp3')
Sound.register(:status, '../sounds/status.mp3')
class Player

  attr_reader :x, :y, :st_flag, :items, :v, :items_flag, :get_item, :index, :msg
  attr_accessor :hp, :maxhp, :encount

  def initialize(field, position)
    @field = field
    @x = position[0]
    @y = position[1]
    @v = 12
    @hp = @maxhp = 100
    @items = {heal: 0, key: 0, usb: 0}
    @items_flag = 0
    @st_flag = 0
    @get_item = "none"
    @msg = 0
    @encount = 0
  end

  def stage_move(field, position, v)
    @field = field
    @x = position[0]
    @y = position[1]
    @v = v
  end

  def control
    @items_flag = 0
    sleep(0.1)
    @index = 1
    if @st_flag == 0
      if Input.key_down?(K_A)
        @v = 4
        @msg = @field[@y][@x - 1]
        if @field[@y][@x - 1] == 0
          @x -= 1
        end
      elsif Input.key_down?(K_D)
        @v = 8
        @msg = @field[@y][@x + 1]
        if @field[@y][@x + 1] == 0
          @x += 1
        end
      elsif Input.key_down?(K_W)
        @v = 12
        @msg = @field[@y - 1][@x]
        if @field[@y - 1][@x] == 0
          @y -= 1
        end
      elsif Input.key_down?(K_S)
        @v = 0
        @msg = @field[@y + 1][@x]
        if @field[@y + 1][@x] == 0
          @y += 1
        end
      end

      if @msg == 3 && items[:key] != 0
        @msg = 2
      elsif @msg == 2
        @msg = 14
      end

      if Input.key_push?(K_Q)
        case @v
        when 4
          case @field[@y][@x - 1]
          when 5
            @items[:heal] += 1
            @field[@y][@x - 1] = 9
            @get_item = :heal
            @items_flag = 1
          when 6
            @items[:key] += 1
            @field[@y][@x - 1] = 9
            @get_item = :key
            @items_flag = 1
          when 7
            @items[:usb] += 1
            @field[@y][@x - 1] = 9
            @get_item = :usb
            @items_flag = 1
          when 8
            @field[@y][@x - 1] = 9
            @index = 2
            @encount = 1
          when 100
            @field[@y][@x - 1] = 9
            @index = 2
            @encount = 2
          end
        when 8
          case @field[@y][@x + 1]
          when 5
            @items[:heal] += 1
            @field[@y][@x + 1] = 9
            @get_item = :heal
            @items_flag = 1
          when 6
            @items[:key] += 1
            @field[@y][@x + 1] = 9
            @get_item = :key
            @items_flag = 1
          when 7
            @items[:usb] += 1
            @field[@y][@x + 1] = 9
            @get_item = :usb
            @items_flag = 1
          when 8
            @field[@y][@x + 1] = 9
            @index = 2
            @encount = 1
          when 100
            @field[@y][@x + 1] = 9
            @index = 2
            @encount = 2
          end
        when 12
          case @field[@y - 1][@x]
          when 5
            @items[:heal] += 1
            @field[@y - 1][@x] = 9
            @get_item = :heal
            @items_flag = 1
          when 6
            @items[:key] += 1
            @field[@y - 1][@x] = 9
            @get_item = :key
            @items_flag = 1
          when 7
            @items[:usb] += 1
            @field[@y - 1][@x] = 9
            @get_item = :usb
            @items_flag = 1
          when 8
            @field[@y - 1][@x] = 9
            @index = 2
            @encount = 1
          when 100
            @field[@y - 1][@x] = 9
            @index = 2
            @encount = 2
          end
        when 0
          case @field[@y + 1][@x]
          when 5
            @items[:heal] += 1
            @field[@y + 1][@x] = 9
            @get_item = :heal
            @items_flag = 1
          when 6
            @items[:key] += 1
            @field[@y + 1][@x] = 9
            @get_item = :key
            @items_flag = 1
          when 7
            @items[:usb] += 1
            @field[@y + 1][@x] = 9
            @get_item = :usb
            @items_flag = 1
          when 8
            @field[@y + 1][@x] = 9
            @index = 2
            @encount = 1
          when 100
            @field[@y + 1][@x] = 9
            @index = 2
            @encount = 2
          end
        end
      end
    else @st_flag == 1
      if Input.key_push?(K_H) && @items[:heal] > 0 && hp < 100
        @hp += 20
        if(@hp > 100)
          @hp = 100
        end
        @items[:heal] -= 1
        Sound[:heal].play
      end
    end
    if Input.key_push?(K_E)
      if @st_flag == 0
        @st_flag = 1
        Sound[:status].play
      else
        @st_flag = 0
      end
    end
    @field
  end
end