class Enemy
   
    def initialize(img,start_x,start_y,pattern,hp,atk_at,atk_sp,skill_pos)
        @img = img
        @x = start_x-@img.width/2
        @y = start_y-@img.height/2
        @pattern = pattern
        @hp = hp
        @v = 1
        @atk_at = atk_at
        @atk_sp = atk_sp
        @atkflag = 0
        @skill_y = @y + skill_pos
        @count=0
    end
    
    def update #mean move
    scaleAmount = 1.0
        case @pattern
        when 0
            Window.draw_scale(@x,@y, @img, scaleAmount, scaleAmount)
            @x += @v
            if @x + @img.width > WINDOW_WIDTH || @x < 0
                @v *= -1
            end
            if @atkflag == 0
                @skill_x = @x
                if rand(1..100) % 100 == 0
                    @atkflag = 1
                end
            end
        end
    end
    
    def attack
        if @atkflag == 1
            case @pattern
            when 0
                Window.draw_circle_fill(@skill_x,@skill_y,@atk_sp+2,C_RED)
                Window.draw_circle_fill(@skill_x,@skill_y,@atk_sp,C_BLUE)
                Window.draw_circle_fill(@skill_x,@skill_y,@count,C_RED)
                @count += 0.5
                if @count > @atk_sp
                    @atkflag = 0
                    #return 1
                end
            end
        else
            @count=0
        end
    end
end