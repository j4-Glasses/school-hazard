require "dxopal"
include DXOpal

require_remote './code/battle.rb'
#require_remote './code/enemy.rb'
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
 # enemies = []
#  enemies[0] = Enemy.new(ball_img,100,0)
#  enemies[1] = Enemy.new(hara_img,300,2)
  
  Window.loop do
     # if Input.mouse_down?(M_RBUTTON) == true
    #   mouse.shield(shield_img)
   
    if Input.mouse_push?(M_LBUTTON) == true
      p "左クリック"
      p M_LBUTTON
      p M_RBUTTON
    end
     if Input.mouse_down?(M_MBUTTON) == true
      p "中クリック"
    end
    
    mouse.update
    if Input.key_down?(K_SPACE) == true
      shieldflag = true
    else
      shieldflag = false
    end
    
    if shieldflag == true
      mouse.shield(shield_img)
    end
    
    if Input.mouse_release?(M_LBUTTON) == true && shotflag == false
      start = Time.now
      shotflag = true
      shot_posx = Input.mouse_x
      shot_posy = Input.mouse_y
      #puts "右クリック"
      #mouse.attack(gunshot_img)
    end
    
    if shotflag == true
      mouse.attack(gunshot_img, shot_posx, shot_posy)
      t = Time.now
      if t.to_f - start.to_f >= 1.0
        shotflag = false
      end
    end
  end
end