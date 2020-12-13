class Enemy
   # attr_accessor :x,:y
    def intitialize(hp,start_x,start_y,pattern)
        @x = start_x
        @y = start_y
        @pattern = pattern
        @hp=hp
    end
    def update(img) #mean move
    scaleAmount = 1.0
        case @pattern
        when nil
        Window.draw_scale(@x.to_i - (img.width * scaleAmount / 2),@y.to_i - (img.height * scaleAmount / 2), img, scaleAmount, scaleAmount)
            @x = @x.to_i + 1
        else
        end
    end

end