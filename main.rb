require "dxopal"
include DXOpal

require_remote './code/battle.rb'
Image.register(:shield, './images/shield.png')
Image.register(:gunshot, './images/gunshot_wound.png')



Window.load_resources do
  Window.height=600
  Window.width=600
  Window.bgcolor=C_BLUE
  shield_img = Image[:shield]
  gunshot_img = Image[:gunshot]
  #shield_img.scale_x=(0.10)
  #shield_img.scale_y=(0.10)

  mouse = Battle.new(shield_img, gunshot_img)
  Window.loop do
    mouse.mouse
    if Input.mouse_down?(M_RBUTTON) == true
      mouse.shield(shield_img)
    elsif Input.mouse_down?(M_LBUTTON) == true
      mouse.attack(gunshot_img)
    end
  end
end