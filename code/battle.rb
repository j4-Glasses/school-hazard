#戦闘のプログラム
class Battle
    def initialize(shield_img)
        @shield_img = shield_img
    end
    def mouse
        @x = Input.mouse_x  # マウスカーソルのx座標
        @y = Input.mouse_y  # マウスカーソルのy座標
        @r = 10
        Window.draw_circle(@x, @y, @r, C_RED, 0)
    end

    def shield
        Window.draw_scale(@x, @y, @shield_img, 0.10, 0.10)
        #Sprite.draw(@x, @y, @shield_img)
    end
end