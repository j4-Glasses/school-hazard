require 'dxopal'
include DXOpal

require_remote './code/player.rb'
require_remote './code/draw.rb'
require_remote './code/music.rb'
require_remote './code/battle.rb'
require_remote './code/enemy.rb'

Image.register(:shield, './images/shield.png')
Image.register(:gunshot, './images/gunshot_wound_white.png')
Image.register(:ball, './images/ball.png')
Image.register(:hara, './images/hara.png')
Image.register(:op, './images/opening.png')
Sound.register(:bgm, './sounds/mainbgm.mp3')

WINDOW_HEIGHT = 550
WINDOW_WIDTH = 550
OPENING = 0
SEARCH = 1
BATTLE = 2
BADEND = 3
CLEAR = 4
BEFORE_BATTLE = 5
WIN_BATTLE = 6

Window.load_resources do
  # Window.bgcolor = [154, 172, 126]
  Window.height = WINDOW_HEIGHT
  Window.width = WINDOW_WIDTH
  Window.bgcolor=C_BLUE

  index = OPENING
  #index = BATTLE
  co_f = 0
  q = 0

  shield_img = Image[:shield]
  gunshot_img = Image[:gunshot]
  ball_img = Image[:ball]
  hara_img = Image[:hara]
  mouse = Battle.new
  shot_posx = 0
  shot_posy = 0
  start = 0
  t = 0
  shieldflag = false
  shotflag = false

  #encount=0
  enemy = 0
  enemyflag = 1
  damage = 0

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
    [9, 8, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 0, 0, 9, 9],
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9]
  ]

  facultyroom = [
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9],
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9],
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9],
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9],
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9],
    [9, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 9, 9],
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9],
    [9, 0, 0, 0, 0, 0, 9, 9, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 9],
    [9, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 9],
    [15, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 9],
    [9, 0, 0, 0, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0, 0, 0, 9],
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 9, 9, 9],
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 0, 9, 9, 9],
    [9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100],
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9],
    [9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9]
  ]

  # pl = Player.new(classroom, [12, 6])
  pl = Player.new(corridor, [4, 20])
  # stage = Draw.new(classroom, 21, 15)
  stage = Draw.new(corridor, 22, 22, :corridor)
  bgm1 = Music.new(:bgm, 330)

  Window.loop do
    case index
    when OPENING
      Window.draw(0, 0, Image[:op])
      index = SEARCH
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
      when 14
        pl.stage_move(facultyroom, [1, 9], 8)
        stage.move_stage(facultyroom, 16, 19, :facultyroom)
        co_f = 2
      when 15
        pl.stage_move(corridor, [20, 7], 4)
        stage.move_stage(corridor, 22, 22, :corridor)
        co_f = 0
      end

      case co_f
      when 0
        corridor = pl.control
      when 1
        classroom = pl.control
      when 2
        facultyroom = pl.control
      end
      index = pl.index
      stage.print_stage(pl.x, pl.y, pl.v)
      stage.print_get_items(pl.items_flag, pl.get_item)
      stage.print_message(pl.msg)

      if pl.st_flag == 1
        stage.print_status(pl.hp, pl.items)
      end

      if pl.encount >= 1
        q = 0
        index = BEFORE_BATTLE
      end
    when BATTLE
      # font = Font.new(90)
      # Window.draw_font(50, 50, "BATTLE", font, color: C_RED)
      # sleep(1)
      # index = SEARCH
      if pl.encount > 0
        if enemyflag == 1
          case pl.encount
          when 1 then
            enemy = Enemy.new(ball_img,200,200,1,100,5,30,300)
          when 2 then
            enemy = Enemy.new(hara_img,300,2,2,10,10,30,300)
          end
          enemyflag = 0
        end

        mouse.update
        enemy.update

        damage = enemy.attack(shieldflag, mouse.x, mouse.y)

        if Input.key_down?(K_SPACE) == true
          shieldflag = true
        else
          shieldflag = false
        end

        if shieldflag == true
          mouse.shield(shield_img)
        end


        if Input.mouse_push?(M_LBUTTON) == true && shotflag == false && shieldflag == false
          start = Time.now
          shotflag = true
          shot_posx = Input.mouse_x
          shot_posy = Input.mouse_y
          #puts "右クリック"
          #mouse.attack(gunshot_img)
          pl.encount = enemy.hit(shot_posx-5,shot_posy-5,gunshot_img)
        end

        if shotflag == true
          mouse.attack(gunshot_img, shot_posx, shot_posy)
          t = Time.now
          if t.to_f - start.to_f >= 1.0
            shotflag = false
          end
        end
        Window.draw_font(10, 20, "#{damage} ", Font.new(18), color: C_WHITE)
        pl.hp -= damage
        Window.draw_font(10, 50, "Your HP ", Font.new(18), color: C_WHITE)
        Window.draw_box_fill(100,55,100+pl.maxhp,60,C_RED)
        Window.draw_box_fill(100,55,100+pl.hp,60,C_GREEN)
        
        if pl.hp <= 0
          index = BADEND
        end
        
      else
        enemyflag = 1
        index = WIN_BATTLE
        q = 0
      end
      #Window.draw_font(50, 50, "encount=#{encount}", Font.new(18), color: C_WHITE)
    when BADEND
    when CLEAR
    when BEFORE_BATTLE
      if q < 150
        stage.print_stage(pl.x, pl.y, pl.v)
        stage.print_battle_message(pl.encount)
      else
        index = BATTLE
      end
      q += 1
    when WIN_BATTLE
      if q < 150
        stage.print_stage(pl.x, pl.y, pl.v)
        stage.print_win_message()
      else
        index = SEARCH
      end
      q += 1
    end
  end
end