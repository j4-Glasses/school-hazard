#戦闘のプログラム
#require 'dxruby'
class Battle
    #def initialize(shield_img, gunshot_img)
    #   @shield_img = shield_img
    #   @gunshot_img = gunshot_img
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
        move_x = shield_img.width * scaleAmount / 2
        move_y = shield_img.height * scaleAmount / 2
        Window.draw_scale(@x - move_x , @y - move_y, shield_img, scaleAmount, scaleAmount, 0, 0) 
        #Sprite.draw(@x, @y, @shield_img)
    end
    
    def attack(gunshot_img, shot_posx, shot_posy)
        #@font = Font.new(10)
        scaleAmount = 0.20
        #now_posx = @x
        #now_posy = @y
        width = gunshot_img.width
        height = gunshot_img.height
        x = shot_posx - ( width * scaleAmount / 2) + 8
        y = shot_posy - ( height * scaleAmount / 2)
        #x = now_posx
        #y = now_posy
        Window.draw_scale(x, y, gunshot_img, scaleAmount, scaleAmount, 0, 0) 
       # Window.draw_font(100, 100, "x : #{x}", @font)
        #Window.draw_font(100, 150, "y : #{y}", @font)
        #Window.draw_font(100, 200, "width : #{width}", @font)
        #Window.draw_font(100, 250, "height : #{height}", @font)
        #Window.draw_font(100, 300, "shot_posx : #{shot_posx}", @font)
        #Window.draw_font(100, 350, "shot_posy : #{shot_posy}", @font)
        #Window.draw_font(100, 400, "scaleAmount : #{scaleAmount}", @font)
        #Window.draw_scale(@x , @y , gunshot_img, 0.20, 0.20, 0, 0) 
    end
end
