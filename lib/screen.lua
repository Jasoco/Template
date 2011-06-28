local graphics = love.graphics
local keyboard = love.keyboard
local color = love.graphics.setColor
local rectangle = love.graphics.rectangle
local draw = love.graphics.draw

local _flr = math.floor
local _min = math.min

displaySettings = {}

function displaySettings:setup(v)
  local _i = {}
  setmetatable(_i, {__index = self})
  _i:reset(v)
  return _i
end
function displaySettings:reset(v)
  v = v or {}
  self.w = v.w or 320
  self.h = v.h or 200
  self.ws = v.scale or 2
  self.ts = v.tileSize or 16
  self.hd = v.hitDivisions or 2
  self.hs = self.ts / self.hd
  self.fls = v.floorScale or true
  self.drawmatte = false
  self.smooth = false
end
function displaySettings:updateScale()
  self.sw = graphics.getWidth()
  self.sh = graphics.getHeight()
  self.s = _min(self.sw / self.w, self.sh / self.h)
  if self.fls then
    self.s = _flr(self.s)
  end
  self.ox = (self.sw - (self.w * self.s)) / 2
  self.oy = (self.sh - (self.h * self.s)) / 2
end
function displaySettings:setMode(s)
  if s == 0 then
    modes = graphics.getModes()
    graphics.setMode(modes[1].width, modes[1].height, true, false)
    self.drawmatte = true
  else
    graphics.setMode(self.w * s, self.h * s, false, false)
    self.drawmatte = false
  end
  self:updateScale()
end

function displaySettings:switchRes()
  local modes = graphics.getModes()
  local mxs = _min(_flr(modes[1].width / self.w), _flr((modes[1].height) / self.h))
  if keyboard.isDown("lshift") then self.ws = self.ws - 1 else self.ws = self.ws + 1 end
  if keyboard.isDown("lctrl") then self.ws = 0 end
  if self.ws > mxs then self.ws = 0 end
  if self.ws < 0 then self.ws = mxs end
  self:setMode(self.ws)
end

function displaySettings:getWidth()
  return self.w
end
function displaySettings:getHeight()
  return self.h
end
function displaySettings:getFloorScale()
  return self.fls
end
function displaySettings:getSmooth()
  return self.smooth
end

function displaySettings:setWidth(w)
  self.w = w
end
function displaySettings:setHeight(h)
  self.h = h
end
function displaySettings:setFloorScale(s)
  self.fls = s
end
function displaySettings:setSmooth(s)
  self.smooth = s
end

function displaySettings:matte()
  if self.drawmatte == true then
    color(0,0,0)
    rectangle("fill", self.ox + self.w * self.s, self.oy, self.w * self.s, (self.h + self.oy) * self.s)
    rectangle("fill", self.ox, self.oy + self.h * self.s, self.w * self.s, self.h * self.s)
  end
end

function displaySettings:prepare()
  graphics.setRenderTarget(self.buffer["main"])
  graphics.setBackgroundColor(255,255,255)
end

function displaySettings:draw()
  graphics.setRenderTarget()

  color(0,0,0)
  rectangle("fill", 0, 0, self.sw, self.sh)

  color(255,255,255)
  rectangle("fill", self.ox, self.oy, self.w * self.s, self.h * self.s)
  draw(self.buffer["main"], self.ox, self.oy, 0, self.s)
end

function createBuffers(w,h)
  w = w or screen.w
  h = h or screen.h
  screen.buffer = {
    ["main"] = graphics.newFramebuffer(nextPO2(w), nextPO2(h))
  }
  if screen.smooth == false then
    for i, f in pairs(screen.buffer) do
      f:setFilter("nearest", "nearest")
    end
  end
  return true
end
