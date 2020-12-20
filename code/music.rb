require 'dxopal'
include DXOpal

class Music
  attr_accessor :bgm

  def initialize(symbol, bgm_length)
    @symbol = symbol
    @bgm_len = bgm_length
    @bgm = bgm_length
  end

  def bgm_play
    if @bgm == @bgm_len
      Sound[@symbol].play
      @bgm = 0
    else
      @bgm += 1
    end
  end

  def bgm_stop
    Sound[@symbol].stop
  end
end