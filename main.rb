require 'dxopal'
include DXOpal
require_remote './code/player.rb'
require_remote './code/draw.rb'
require_remote './code/control.rb'

Sound.register(:bgm, './sounds/mainbgm.mp3')
FIELD_SIZE_H = 550
FIELD_SIZE_W = 550
BLOCK_NUM_H = 21
BLOCK_NUM_W = 15

Window.load_resources do
  Window.bgcolor = [154, 172, 126]
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
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9],
    [9, 0, 0, 9, 0, 9, 0, 9, 0, 5, 0, 9, 0, 0, 9],
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9],
    [9, 0, 0, 5, 0, 9, 0, 5, 0, 9, 0, 9, 0, 0, 9],
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9],
    [9, 0, 0, 9, 0, 9, 0, 9, 0, 9, 0, 9, 0, 0, 9],
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9],
    [9, 0, 0, 5, 0, 9, 0, 9, 0, 6, 0, 9, 0, 0, 9],
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9],
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9],
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9],
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9]
  ]
  pl = Player.new(field, [4, 4])
  stage1 = Draw.new(field, BLOCK_NUM_H, BLOCK_NUM_W)
  bgm_start = 0
  Window.loop do
    if bgm_start == 0
      Sound[:bgm].play
      bgm_start = 1
    end
    field = pl.control
    stage1.print_stage(pl.x, pl.y, pl.v)
    if pl.item_flag == 1
      stage1.print_status(pl.hp, pl.items)
    end
  end
end