require "dxopal"
include DXOpal

require_remote './code/battle.rb'
require_remote './code/enemy.rb'
Image.register(:shield, './images/shield.png')
Image.register(:gunshot, './images/gunshot_wound_white.png')
Image.register(:ball, './images/ball.png')
Image.register(:hara, './images/hara.png')

WINDOW_HEIGHT = 550
WINDOW_WIDTH = 550

Window.load_resources do
  Window.height = WINDOW_HEIGHT
  Window.width = WINDOW_WIDTH
  Window.bgcolor=C_BLUE
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
  
  encount=0
  enemy = 0
  enemyflag = 1
  bflag = 0
  
  #e_ball = Enemy.new(ball_img,200,200,1,100,10,30,300)
    #e_hara = Enemy.new(hara_img,300,2,10,10)
  
  Window.loop do
    
    if encount > 0
      if enemyflag == 1
        case encount
        when 1 then
          enemy = Enemy.new(ball_img,200,200,1,100,10,30,300)
        when 2 then
          enemy = Enemy.new(hara_img,300,2,10,10,10,30,300)
        end
        enemyflag = 0
      end

      mouse.update
      enemy.update
    
      enemy.attack(shieldflag, mouse.x, mouse.y)
      
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
        encount = enemy.hit(shot_posx-5,shot_posy-5,gunshot_img)
      end
      
      if shotflag == true
        mouse.attack(gunshot_img, shot_posx, shot_posy)
        t = Time.now
        if t.to_f - start.to_f >= 1.0
          shotflag = false
        end
      end
    else
       enemyflag = 1
       if Input.mouse_push?(M_LBUTTON)
         encount = 1#rand(1..2)
       end
       
    end
    Window.draw_font(50, 50, "encount=#{encount}", Font.new(18), color: C_WHITE)
  end
end