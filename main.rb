require "dxopal"
include DXOpal

require_remote './code/battle.rb'
Image.register(:shield, './images/shield.png')



Window.load_resources do
  Window.height=600
  Window.width=600
  shield_img = Image[:shield]
  #shield_img.scale_x=(0.10)
  #shield_img.scale_y=(0.10)

  mouse = Battle.new(shield_img)
  Window.loop do
    mouse.mouse
    if Input.mouse_down?(M_RBUTTON) == true
      mouse.shield
    end
  end
end