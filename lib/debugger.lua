local graphics = love.graphics
local _flr = math.floor

debugger = {}

function debugger:init(v)
  local _i = {}
  setmetatable(_i, {__index = self})
  _i:reset(v)
  return _i
end
function debugger:reset(v)
  v = v or {}
  v.key = v.key or "`"
  self.on = true
  self.updates = 0
  self.framerates = 0
  self.average = 0
  self.key = string.lower(v.key)
  self.font = v.font or font["tiny"]
end
function debugger:update()
  self.updates = self.updates + 1
  self.framerates = self.framerates + fps
  if self.on == true then
    self.average = self.framerates / self.updates
  end
end
function debugger:draw(dt)
  if self.on == true then
    local t = "FPS: " .. fps .. " (" .. _flr(self.average) .. ")" .. "\nX: " .. m.x .. "\nY: " .. m.y
    graphics.setFont(self.font)
    graphics.setColor(0,0,0)
    graphics.print(t, 2, 2)
  end
end

function debugger:enable() self.on = true end
function debugger:disable() self.on = false end
function debugger:toggle() self.on = not self.on end
