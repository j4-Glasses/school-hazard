#戦闘のプログラム
class Battle < Sprite
    def update
        @x = Input.mouse_x  # マウスカーソルのx座標
        @y = Input.mouse_y  # マウスカーソルのy座標
        @r = 10
        Window.draw_circle(@x, @y, @r, C_RED, 0)
    end

    def shield(shield_img)
        scaleAmount = 0.10
        Window.draw_scale(@x - (shield_img.width * scaleAmount / 2),@y - (shield_img.height * scaleAmount / 2), shield_img, scaleAmount, scaleAmount, 0, 0) 
    end
    
    def attack(gunshot_img)
        scaleAmount = 0.20
        Window.draw_scale(@x - (gunshot_img.width * scaleAmount / 2) + 6, @y - (gunshot_img.height * scaleAmount / 2), gunshot_img, scaleAmount, scaleAmount, 0, 0) 
    end
end