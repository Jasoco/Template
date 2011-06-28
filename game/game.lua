local mouse = love.mouse
local printg = love.graphics.print
local setFont = love.graphics.setFont
local keyDown = love.keyboard.isDown

local _flr = math.floor
local _max = math.max
local _min = math.min

gameInit = {}

function gameInit:create(v)
  local _i = {}
  setmetatable(_i, {__index = self})
  _i:settings(v)
  return _i
end
function gameInit:settings(v)
  v = v or {}

end

function gameInit:update()

end
function gameInit:draw()

end
function gameInit:keyPressed(k)

end
function gameInit:mousePressed(x, y, button)

end

