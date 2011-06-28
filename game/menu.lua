local mouse = love.mouse
local printg = love.graphics.print
local setFont = love.graphics.setFont

local _flr = math.floor
local _max = math.max
local _min = math.min

menuInit = {}

function menuInit:create(v)
  local _i = {}
  setmetatable(_i, {__index = self})
  _i:settings(v)
  return _i
end
function menuInit:settings(v)
  v = v or {}

  self.gui = gui:create()
  self.gui:add({type = "button", x = 40, y = 70, w = 100, h = 20, title = "Title 1"})
  self.gui:add({type = "button", x = 180, y = 40, w = 100, h = 20, title = "Options",
    click = function() game.mode = "options" end})
  self.gui:add({type = "button", x = 40, y = 40, w = 100, h = 20, title = "Play Game",
    click = function() game.mode = "game" end})
  self.gui:add({type = "toggle", x = 180, y = 70, w = 100, h = 20, title = "Title 4"})

end

function menuInit:update()
  self.gui:update(self)
end
function menuInit:draw()
  self.gui:draw()
end
function menuInit:keyPressed(k)
  self.gui:keyPressed(k)
end
function menuInit:mousePressed(x, y, button)

end

