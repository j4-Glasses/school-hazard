class Enemy
    attr_reader :pattern
    #start_x, start_y : 敵の初期位置 atk_at : 敵の攻撃力 atk_sp : 敵攻撃の赤丸の埋まる速度 skill_pos : 敵攻撃の表示位置(中心)
    def initialize(img,start_x,start_y,pattern,hp,atk_at,atk_sp,skill_pos)
        @img = img
        @x = start_x-@img.width/2
        @y = start_y-@img.height/2
        @pattern = pattern
        @maxhp = @hp =hp
        @vx = 1
        @vy = 1
        @atk_at = atk_at
        @atk_sp = atk_sp
        @atkflag = 0    #攻撃フラグ(1のとき攻撃が発生)
        @skill_x = 0
        @skill_y = @y + skill_pos
        @count = 0
        #あたり判定を判別しやすくするためSpriteを用意
        if @pattern == 1
            @s = Sprite.new(@x+20,@y+80,Image.new(140,140))
        else
            @s = Sprite.new(@x,@y,Image.new(@img.width,@img.height))
        end
    end
    
    def update #mean move
        scaleAmount = 1.0
        #Window.draw_font(10, 10, "pattern = #{@pattern}", Font.new(18), color: C_WHITE)#for debug
        #敵の表示
        Window.draw_scale(@x,@y, @img, scaleAmount, scaleAmount)
        Window.draw_box_fill(@x,@y+@img.height+1,@x+@maxhp,@y+@img.height+10,C_RED)
        Window.draw_box_fill(@x,@y+@img.height+1,@x+@hp,@y+@img.height+10,C_GREEN)

        #敵の攻撃パターン設定
        case @pattern
        when 1 then #ザコ敵
            @x += @vx
            @y += @vy
            #壁で跳ね返る
            if @x + @img.width > WINDOW_WIDTH || @x < 0
                @vx *= -1
            end
            if @y + @img.height > WINDOW_HEIGHT || @y < 0
                @vy *= -1
            end

            #乱数で攻撃するか決定
            if @atkflag == 0
                @skill_x = @x
                if rand(1..100) % 50 == 0
                    @atkflag = 1
                end
            end
            @s.x=@x+20
            @s.y=@y+80
        when 2 then #ボス
            @x += @vx * 3
            @y += @vy * 3
            #壁ですり抜け
            if @x + @img.width > WINDOW_WIDTH
                @x = 0
            end
            if @y + @img.height > WINDOW_HEIGHT
                @y = 0
            end

            #乱数で攻撃するか決定
            if @atkflag == 0
                @skill_x = @x
                if rand(1..100) % 20 == 0
                    @atkflag = 1
                end
            end
            @s.x=@x
            @s.y=@y
        end
    end

    #敵の攻撃
    def attack(shieldflag, mouse_x, mouse_y)
        mouse = Sprite.new(mouse_x, mouse_y, Image.new(1,1))    #マウス用のSprite
        #敵の攻撃スピード(丸が埋まっていく速さ)の設定
        atk_speed = @atk_sp
        atk_speed_double = @atk_sp * 2
        #敵の攻撃の表示位置
        skill_x = @skill_x
        skill_y = @skill_y
        ret = 0
        #攻撃フラグが立ってたら攻撃
        if @atkflag == 1
            case @pattern
            when 1 then #ザコ敵
                enemy_skill = Sprite.new(skill_x - atk_speed, skill_y - atk_speed, Image.new(atk_speed_double, atk_speed_double))
                Window.draw_circle_fill(@skill_x,@skill_y,@atk_sp+2,C_RED)
                Window.draw_circle_fill(@skill_x,@skill_y,@atk_sp,C_BLUE)
                Window.draw_circle_fill(@skill_x,@skill_y,@count,C_RED)
            when 2 then
                skill_x = @x
                skill_y = @y
                enemy_skill = Sprite.new(skill_x - atk_speed, skill_y - atk_speed+ @img.height / 2 - 20, Image.new(atk_speed_double, atk_speed_double))
                Window.draw_circle_fill(skill_x,skill_y + @img.height / 2 - 20,@atk_sp+2,C_RED)
                Window.draw_circle_fill(skill_x,skill_y + @img.height / 2 - 20,@atk_sp,C_BLUE)
                Window.draw_circle_fill(skill_x,skill_y + @img.height / 2 - 20,@count,C_RED)
            end
            #Window.draw_box_fill(skill_x - atk_speed,skill_y - atk_speed+ @img.height / 2 - 20,skill_x+atk_speed_double, skill_y+atk_speed_double+ @img.height / 2 - 20,[255,255,0,0.4])
            @count += 0.5
            if @count > @atk_sp
                @atkflag = 0
                #シールドが出ていて, 敵の攻撃とシールド(マウス)が重なってたら
                if shieldflag == true && enemy_skill === mouse then
                    #Window.draw_font(10, 70, "GUARD", Font.new(18), color: C_WHITE)
                    ret = 0
                else
                    #Window.draw_font(10, 70, "DAMAGED", Font.new(18), color: C_WHITE)
                    ret = @atk_at
                end
            end
        else
            @count=0
        end
        return ret
    end

    #銃で敵を射撃(こちらの攻撃)
    def hit(x,y)
        ret = 1
        g=Sprite.new(x,y,Image.new(10,10))
        if @s === g
                Window.draw_font(@s.x, @s.y, "HIT", Font.new(18), color: C_WHITE)
                @hp-=10
        end

        case @pattern
        when 1 then
        end

        if @hp == 0
            ret = 0
        end

        return ret
    end

end