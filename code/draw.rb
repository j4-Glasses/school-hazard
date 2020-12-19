require 'dxopal'
include DXOpal

Image.register(:class, '../images/classroom.png')
Image.register(:corridor, '../images/corridor.png')
Image.register(:facultyroom, '../images/corridor.png')
Image.register(:funa, '../images/funa2.png')
Image.register(:status, '../images/sta_ms.png')
Image.register(:message, '../images/ms1.png')
Sound.register(:get, '../sounds/item_get.mp3')
class Draw

  BLOCK_H = 50
  BLOCK_W = 50
  PL_TILE_X = 4
  PL_TILE_Y = 4

  def initialize(field, field_size_h, field_size_w, symbol)
    @field = field
    @field_h = field_size_h
    @field_w = field_size_w
    @font = Font.new(32)
    @images = Image[:funa].slice_tiles(PL_TILE_X, PL_TILE_Y)
    @im_field = Image[symbol].slice_tiles(@field_w - 2, @field_h - 2)
    @pl_tile_f = 0
    @i = 0
    @it_flag = 0
  end

  def move_stage(field, field_size_h, field_size_w, symbol)
    @field = field
    @field_h = field_size_h
    @field_w = field_size_w
    @im_field = Image[symbol].slice_tiles(@field_w - 2, @field_h - 2)
  end

  def print_stage(pl_x, pl_y, pl_v)
    11.times do |y|
      11.times do |x|
        dx = pl_x + x - 5
        dy = pl_y + y - 5
        if 1 <= dx && dx < @field_w - 1 && 1 <= dy && dy < @field_h - 1
          #case @field[dy][dx]
          #when 0
          #  Window.draw_box_fill(x*BLOCK_W, y*BLOCK_H, x*BLOCK_W+BLOCK_W, y*BLOCK_H+BLOCK_H, [100, 100, 100])
          #when 5
          #  Window.draw_box_fill(x*BLOCK_W, y*BLOCK_H, x*BLOCK_W+BLOCK_W, y*BLOCK_H+BLOCK_H, [20, 100, 20])
          #when 5
          #when 6
          #  Window.draw_box_fill(x*BLOCK_W, y*BLOCK_H, x*BLOCK_W+BLOCK_W, y*BLOCK_H+BLOCK_H, [100, 20, 20])
          #when 7
          #  Window.draw_box_fill(x*BLOCK_W, y*BLOCK_H, x*BLOCK_W+BLOCK_W, y*BLOCK_H+BLOCK_H, [20, 20, 100])
          #when 9
          #  Window.draw_box_fill(x*BLOCK_W, y*BLOCK_H, x*BLOCK_W+BLOCK_W, y*BLOCK_H+BLOCK_H, [200, 100, 0])
          #end
          Window.draw(x*BLOCK_W, y*BLOCK_H, @im_field[(dx-1)+(dy-1)*(@field_w-2)])
        end
        if x == 5 && y == 5
          Window.draw(x*BLOCK_W, y*BLOCK_H-40, @images[pl_v+@pl_tile_f])
          @pl_tile_f += 1
          if @pl_tile_f == 4
            @pl_tile_f = 0
          end
        end
      end
    end
  end

  def print_get_items(flag, item)
    font = Font.new(32)
    if flag == 1
      @it_flag = 1
      @i = 0
      @pr_item = item
      Sound[:get].play
    end
    if @it_flag == 1
      @i += 1
      Window.draw(0, 430, Image[:message])
      Window.draw_font(120, 480, "#{@pr_item}を入手しました!!", font)
    end
    if @i > 30
      @it_flag = 0
    end
  end

  def print_message(msg)
    font = Font.new(32)
    if msg != 0
      @m = msg
      @i = 0
    end
    case @m
    when 1
      @i += 1
      Window.draw(0, 430, Image[:message])
      Window.draw_font(70, 480, "これ以上先に進めないだと!?", font)
    when 3
      @i += 1
      Window.draw(0, 430, Image[:message])
      Window.draw_font(70, 480, "鍵がないというのかッッ!?", font)
    end
    if @i > 10
      @m = 0
    end
  end

  def print_status(hp, items)
    Window.draw(0, 0, Image[:status])
    font = Font.new(42)
    Window.draw_font(200, 40, "STATUS", font, color: C_RED)
    Window.draw_font(200, 160, "腐那死威", font, color: C_RED)
    font = Font.new(32)
    Window.draw_font(100, 240, "HP   : #{hp}/100", font)
    Window.draw_font(100, 310, "HEAL : #{items[:heal]}", font)
    Window.draw_font(100, 380, "KEY  : #{items[:key]}", font)
    Window.draw_font(100, 450, "USB  : #{items[:usb]}", font)
    Window.draw_scale(400, 320, @images[@pl_tile_f], 3, 3)
  end
end