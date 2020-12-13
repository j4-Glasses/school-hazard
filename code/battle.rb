#戦闘のプログラム
class Battle
    #def initialize(shield_img, gunshot_img)
     #   @shield_img = shield_img
      #  @gunshot_img = gunshot_img
    #end
    def mouse
        @x = Input.mouse_x  # マウスカーソルのx座標
        @y = Input.mouse_y  # マウスカーソルのy座標
        @r = 10
        Window.draw_circle(@x, @y, @r, C_RED, 0)
    end

    def shield(shield_img)
        #Window.draw_scale(@x-48, @y-48, @shield_img, 0.10, 0.10, 0, 0) 
        scaleAmount = 0.10
        Window.draw_scale(@x - (shield_img.width * scaleAmount / 2), @y - (shield_img.height * scaleAmount / 2), shield_img, scaleAmount, scaleAmount, 0, 0) 
        #Sprite.draw(@x, @y, @shield_img)
    end
    
    def attack(gunshot_img)
        scaleAmount = 0.20
        Window.draw_scale(@x - (gunshot_img.width * scaleAmount / 2) + 6, @y - (gunshot_img.height * scaleAmount / 2), gunshot_img, scaleAmount, scaleAmount, 0, 0) 
        #Window.draw_scale(@x , @y , gunshot_img, 0.20, 0.20, 0, 0) 
    end
end