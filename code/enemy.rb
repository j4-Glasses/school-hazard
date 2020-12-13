class Enemy < Sprite
    def intitialize(img,hp,pattern,start_pos_x,start_pos_y)
        super
        @img = img
        @hp = hp
        @pattern = pattern
        @pos_x = start_pos_x
        @pos_y = start_pos_y
    end
    def update #mean move
    scaleAmount = 0.5
        case @pattern
        when 0
            Window.draw_scale(@pos_x - (@img.width * scaleAmount / 2) + 6, @pos_y - (@img.height * scaleAmount / 2), @img, scaleAmount, scaleAmount, 0, 0)
            @pos_x = @pos_x + 1
            
        end
    end
    def hit
        
    end
    def statas
        
    end
end