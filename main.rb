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
  #encount=0
  e_ball = Enemy.new(ball_img,200,200,0,100,10,30,300)
  #e_hara = Enemy.new(hara_img,300,2,10,10)
  
  Window.loop do
    mouse.update
    e_ball.update
    #e_hara.update
    
     e_ball.attack
    
    if Input.mouse_down?(M_RBUTTON) == true
      mouse.shield(shield_img)
    elsif Input.mouse_down?(M_LBUTTON) == true
      mouse.attack(gunshot_img)
    end
  end
end