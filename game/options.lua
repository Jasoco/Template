local mouse = love.mouse
local printg = love.graphics.print
local setFont = love.graphics.setFont
local keyDown = love.keyboard.isDown

local _flr = math.floor
local _max = math.max
local _min = math.min

optionsInit = {}

function optionsInit:create(v)
  local _i = {}
  setmetatable(_i, {__index = self})
  _i:settings(v)
  return _i
end
function optionsInit:settings(v)
  v = v or {}

end

function optionsInit:update()

end
function optionsInit:draw()

end
function optionsInit:keyPressed(k)

end
function optionsInit:mousePressed(x, y, button)

end

