require 'dxopal'
include DXOpal
require_remote './code/player.rb'
require_remote './code/draw.rb'
require_remote './code/music.rb'

Sound.register(:bgm, './sounds/mainbgm.mp3')
FIELD_SIZE_H = 550
FIELD_SIZE_W = 550
OPENING = 0
SEARCH = 1
BATTLE = 2
ENDEND = 3
CLEAR = 4

Window.load_resources do
  # Window.bgcolor = [154, 172, 126]
  Window.bgcolor = [0, 0, 0]
  Window.height = FIELD_SIZE_H
  Window.width = FIELD_SIZE_W
  index = SEARCH

  co_f = 0

  classroom = [
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9],
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9],
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9],
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9],
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9],
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9],
    [9, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 12],
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
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13],
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9],
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 8, 0, 0, 9],
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9]
  ]
  corridor = [
    [9, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9],
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9],
    [10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9],
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9],
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9],
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9],
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9],
    [9, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 3],
    [9, 0, 0, 0, 0, 0, 9, 9, 9, 0, 0, 0, 0, 9, 9, 9, 0, 0, 0, 0, 0, 9],
    [9, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 9],
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9],
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9],
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9],
    [11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9],
    [9, 9, 9, 9, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 9, 9, 9, 9],
    [9, 9, 9, 9, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 9, 9, 9, 9],
    [9, 9, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 9, 9],
    [9, 9, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 9, 9],
    [9, 9, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 9, 9],
    [9, 9, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 9, 9],
    [9, 9, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 9, 9],
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9]
  ]
  # pl = Player.new(classroom, [12, 6])
  pl = Player.new(corridor, [4, 20])
  # stage = Draw.new(classroom, 21, 15)
  stage = Draw.new(corridor, 22, 22, :corridor)
  bgm1 = Music.new(:bgm, 330)

  Window.loop do
    case index
    when OPENING
    when SEARCH
      bgm1.bgm_play
      case pl.msg
      when 10
        pl.stage_move(classroom, [13, 6], 4)
        stage.move_stage(classroom, 21, 15, :class)
        co_f = 1
      when 11
        pl.stage_move(classroom, [13, 17], 4)
        stage.move_stage(classroom, 21, 15, :class)
        co_f = 1
      when 12
        pl.stage_move(corridor, [1, 2], 8)
        stage.move_stage(corridor, 22, 22, :corridor)
        co_f = 0
      when 13
        pl.stage_move(corridor, [1, 13], 8)
        stage.move_stage(corridor, 22, 22, :corridor)
        co_f = 0
      end
      case co_f
      when 0
        corridor = pl.control
      when 1
        classroom = pl.control
      end
      index = pl.index
      stage.print_stage(pl.x, pl.y, pl.v)
      stage.print_get_items(pl.items_flag, pl.get_item)
      stage.print_message(pl.msg)

      if pl.st_flag == 1
        stage.print_status(pl.hp, pl.items)
      end
    when BATTLE
      font = Font.new(90)
      Window.draw_font(50, 50, "BATTLE", font, color: C_RED)
      sleep(1)
      index = SEARCH
    when BADEND
    when CLEAR
    end
  end
end