require 'dxopal'
include DXOpal

class Draw

  BLOCK_H = 50
  BLOCK_W = 50

  def initialize(field, field_size_h, field_size_w)
    @field = field
    @field_h = field_size_h
    @field_w = field_size_w
    @font = Font.new(32)
  end

  def print_stage(pl_x, pl_y)
    11.times do |y|
      11.times do |x|
        dx = pl_x + x - 5
        dy = pl_y + y - 5
        if 0 <= dx && dx < @field_w && 0 <= dy && dy < @field_h
          case @field[dy][dx]
          when 0
            Window.draw_box_fill(x*BLOCK_W, y*BLOCK_H, x*BLOCK_W+BLOCK_W, y*BLOCK_H+BLOCK_H, [100, 100, 100])
          when 9
            Window.draw_box_fill(x*BLOCK_W, y*BLOCK_H, x*BLOCK_W+BLOCK_W, y*BLOCK_H+BLOCK_H, [200, 100, 0])
          end
        end
        if x == 5 && y == 5
          Window.draw_box_fill(x*BLOCK_W, y*BLOCK_H, x*BLOCK_W+BLOCK_W, y*BLOCK_H+BLOCK_H, [0, 200, 100])
        end
      end
    end
  end
  def print_status(hp, items)
    Window.draw_font(100, 100, "HP   : #{hp}", @font)
    Window.draw_font(100, 200, "HEAL : #{items[:heal]}", @font)
    Window.draw_font(100, 300, "KEY  : #{items[:key]}", @font)
    Window.draw_font(100, 400, "USB  : #{items[:usb]}", @font)
  end
end