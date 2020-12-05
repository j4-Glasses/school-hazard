require "dxopal"
include DXOpal

require_remote 'battle.rb'

Window.load_resources do
  Window.loop do
    Battle.mouse
  end
end