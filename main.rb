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
OPENING = 0
SEARCH = 1
BATTLE = 2
ENDING = 3

Window.load_resources do
  # Window.bgcolor = [154, 172, 126]
  Window.bgcolor = [0, 0, 0]
  Window.height = FIELD_SIZE_H
  Window.width = FIELD_SIZE_W
  index = SEARCH

  field = [
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9],
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9],
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9],
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9],
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9],
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9],
    [9, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 9],
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9],
    [9, 0, 0, 8, 0, 9, 0, 9, 0, 9, 0, 9, 0, 0, 9],
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
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 8, 0, 0, 9],
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9]
  ]
  pl = Player.new(field, [12, 6])
  stage1 = Draw.new(field, BLOCK_NUM_H, BLOCK_NUM_W)
  bgm1 = Music.new(:bgm, 330)
  Window.loop do
    case index
    when OPENING
    when SEARCH
      bgm1.bgm_play
      field = pl.control
      index = pl.index
      stage1.print_stage(pl.x, pl.y, pl.v)
      stage1.print_get_items(pl.items_flag, pl.get_item)

      if pl.st_flag == 1
        stage1.print_status(pl.hp, pl.items)
      end
    when BATTLE
      font = Font.new(90)
      Window.draw_font(50, 50, "BATTLE", font, color: C_RED)
      sleep(1)
      index = SEARCH
    when ENDING
    end
  end
end