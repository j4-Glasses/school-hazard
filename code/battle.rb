#戦闘のプログラム
class Battle
    def mouse
        x = Input.mouse_pos_x  # マウスカーソルのx座標
        y = Input.mouse_pos_y  # マウスカーソルのy座標
        r = 10
        Window.draw_circle(x, y, r, C_RED, 0)
    end
end