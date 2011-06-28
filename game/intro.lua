local mouse = love.mouse
local printg = love.graphics.print
local setFont = love.graphics.setFont
local keyDown = love.keyboard.isDown

local _flr = math.floor
local _max = math.max
local _min = math.min

introInit = {}

function introInit:create(v)
  local _i = {}
  setmetatable(_i, {__index = self})
  _i:settings(v)
  return _i
end
function introInit:settings(v)
  v = v or {}
  self.timer = 2
end

function introInit:update()
  self.timer = self.timer - dt
  if self.timer <= 0 then
    game.mode = "menu"
  end
end
function introInit:draw()

end
function introInit:keyPressed(k)

end
function introInit:mousePressed(x, y, button)

end

