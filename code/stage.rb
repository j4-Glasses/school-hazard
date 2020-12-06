require 'dxopal'
include DXOpal

Image.register(:stu_desk, '../images/stu_desk.png')
Image.register(:stu_chair, '../images/stu_chair.png')
Image.register(:stu_desk_chair, '../images/stu_desk_chair.png')
Image.register(:black_board, '../images/black_board.png')
class Stage

  IM_BACK = 0
  IM_WALL = 1
  IM_STU_DESK = 2
  IM_STU_CHAIR = 3
  IM_STU_DESK_CHAIR = 4
  IM_BLACK_BOALD = 5
  IM_DOOR = 6
  BLOCK_H = 50
  BLOCK_W = 50

  def initialize(image_position, position, field_size_h, field_size_w)
    @im_pos = image_position
    @pos = image_position
    @field_h = field_size_h
    @field_w = field_size_w
  end

  def print_stage
    @field_h.times do |h|
      @field_w.times do |w|
        case @im_pos[h][w]
        when IM_BACK
        when IM_WALL
          Window.draw_box_fill(w*BLOCK_W, h*BLOCK_H, w*BLOCK_W+BLOCK_W, h*BLOCK_H+BLOCK_H, [100, 100, 100])
        when IM_STU_DESK
          Window.draw(w * BLOCK_W, h * BLOCK_H, Image[:stu_desk])
        when IM_STU_CHAIR
          Window.draw(w * BLOCK_W, h * BLOCK_H, Image[:stu_chair])
        when IM_STU_DESK_CHAIR
          Window.draw(w * BLOCK_W, h * BLOCK_H, Image[:stu_desk_chair])
        when IM_BLACK_BOALD
          Window.draw(w * BLOCK_W, h * BLOCK_H, Image[:black_board])
        when IM_DOOR
          Window.draw_box_fill(w*BLOCK_W + (BLOCK_W - 5), h*BLOCK_H, w*BLOCK_W+BLOCK_W, h*BLOCK_H+BLOCK_H, [179, 179, 179])
          Window.draw_box_fill(w*BLOCK_W + (BLOCK_W - 5), h*BLOCK_H + BLOCK_H, w*BLOCK_W+BLOCK_W, h*BLOCK_H+BLOCK_H+(BLOCK_H), [100, 100, 100])
        end
      end
    end
  end
end