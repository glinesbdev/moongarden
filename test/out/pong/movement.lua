local dirs = {down = {0, 1}, left = {-1, 0}, right = {1, 0}, up = {0, -1}}
for key, delta in pairs(dirs) do
  if love.keyboard.isDown(key) then
    local _let_0_ = delta
    local dx = _let_0_[1]
    local dy = _let_0_[2]
    local _let_1_ = player
    local px = _let_1_[1]
    local py = _let_1_[2]
    local x = (px + (dx * player.speed * dt))
    local y = (py + (dy * player.speed * dt))
    world:move(player, x, y)
  end
end
return nil