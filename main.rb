require "dxopal"
include DXOpal

require_remote './code/battle.rb'
require_remote './code/enemy.rb'
Image.register(:shield, './images/shield.png')
Image.register(:gunshot, './images/gunshot_wound.png')
Image.register(:ball, './images/ball.png')
Image.register(:hara, './images/hara.png')

WINDOW_HEIGHT = 600
WINDOW_WIDTH = 600

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
  
  e_ball = Enemy.new(ball_img,200,200,1,100,10,30,300)
    #e_hara = Enemy.new(hara_img,300,2,10,10)
  
  Window.loop do
    mouse.update
    e_ball.update
    #encount=0
    
    e_ball.attack
    if Input.key_down?(K_SPACE) == true
      shieldflag = true
    else
      shieldflag = false
    end
    
    if shieldflag == true
      mouse.shield(shield_img)
    end
    
    if Input.mouse_push?(M_LBUTTON) == true && shotflag == false
      start = Time.now
      shotflag = true
      shot_posx = Input.mouse_x
      shot_posy = Input.mouse_y
      #puts "右クリック"
      #mouse.attack(gunshot_img)
      e_ball.hit(shot_posx-5,shot_posy-5,gunshot_img)
    end
    
    if shotflag == true
      mouse.attack(gunshot_img, shot_posx, shot_posy)
      t = Time.now
      if t.to_f - start.to_f >= 1.0
        shotflag = false
      end
    end
       
       Window.draw_font(50, 50, "(x,y) = (#{mouse.x},#{mouse.y})", Font.new(18), color: C_WHITE)#マウスの位置表示
        
  end
end