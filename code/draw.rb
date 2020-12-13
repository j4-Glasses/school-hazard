require 'dxopal'
include DXOpal

Image.register(:funa, '../images/funa.png')
class Draw

  BLOCK_H = 50
  BLOCK_W = 50
  PL_TILE_X = 4
  PL_TILE_Y = 4

  def initialize(field, field_size_h, field_size_w)
    @field = field
    @field_h = field_size_h
    @field_w = field_size_w
    @font = Font.new(32)
    @images = Image[:funa].slice_tiles(PL_TILE_X, PL_TILE_Y)
    @pl_tile_f = 0
  end

  def print_stage(pl_x, pl_y, pl_v)
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
          if @pl_tile_f == 4
            @pl_tile_f = 0
          end
          Window.draw(x*BLOCK_W, y*BLOCK_H-40, @images[pl_v+@pl_tile_f])
          @pl_tile_f += 1
        end
      end
    end
  end
  def print_status(hp, items)
    Window.draw_box_fill(0, 0, 11 * BLOCK_W, 11 * BLOCK_H , [0, 200, 10])
    Window.draw_box_fill(50, 100, 11 * BLOCK_W - 50, 11 * BLOCK_H - 50 , [0, 20, 10])
    Window.draw_font(100, 10, "--------status--------", @font)
    Window.draw_font(100, 150, "HP   : #{hp}", @font)
    Window.draw_font(100, 250, "HEAL : #{items[:heal]}", @font)
    Window.draw_font(100, 350, "KEY  : #{items[:key]}", @font)
    Window.draw_font(100, 450, "USB  : #{items[:usb]}", @font)
  end
end