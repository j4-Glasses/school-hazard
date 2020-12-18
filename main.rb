require 'dxopal'
include DXOpal
require_remote './code/player.rb'
require_remote './code/draw.rb'
require_remote './code/music.rb'

Sound.register(:bgm, './sounds/mainbgm.mp3')
FIELD_SIZE_H = 550
FIELD_SIZE_W = 550
BLOCK_NUM_H = 21
BLOCK_NUM_W = 15

Window.load_resources do
  # Window.bgcolor = [154, 172, 126]
  Window.bgcolor = [0, 0, 0]
  Window.height = FIELD_SIZE_H
  Window.width = FIELD_SIZE_W

  field = [
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9],
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9],
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9],
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9],
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9],
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9],
    [9, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 9],
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9],
    [9, 0, 0, 9, 0, 9, 0, 9, 0, 9, 0, 9, 0, 0, 9],
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 9],
    [9, 0, 0, 9, 0, 9, 0, 9, 0, 5, 0, 9, 0, 0, 9],
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9],
    [9, 0, 0, 5, 0, 9, 0, 5, 0, 9, 0, 9, 0, 0, 9],
    [9, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 9],
    [9, 0, 0, 9, 0, 9, 0, 9, 0, 9, 0, 9, 0, 0, 9],
    [9, 0, 0, 9, 0, 9, 0, 0, 0, 0, 0, 9, 0, 0, 9],
    [9, 0, 0, 5, 0, 9, 0, 9, 0, 6, 0, 9, 0, 0, 9],
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9],
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9],
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 9],
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9]
  ]
  pl = Player.new(field, [12, 6])
  stage1 = Draw.new(field, BLOCK_NUM_H, BLOCK_NUM_W)
  bgm1 = Music.new(:bgm, 330)
  Window.loop do
    bgm1.bgm_play
    field = pl.control
    stage1.print_stage(pl.x, pl.y, pl.v)
    stage1.print_get_items(pl.items_flag, pl.get_item)

    # font = Font.new(40)
    # Window.draw_font(200, 40, "#{pl.items_flag} #{pl.get_item}", font, color: C_RED)
    if pl.st_flag == 1
      stage1.print_status(pl.hp, pl.items)
    end
    # font = Font.new(40)
    # Window.draw_font(200, 40, "#{bgm}", font, color: C_RED)
  end
end