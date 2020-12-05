require "dxopal"
include DXOpal

require_remote 'battle.rb'

Window.load_resources do
  mouse = Battle.new
  Window.loop do
    mouse.mouse
  end
end