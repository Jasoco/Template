local mouse = love.mouse
local graphics = love.graphics
local keyboard = love.keyboard
local color = love.graphics.setColor
local rectangle = love.graphics.rectangle
local draw = love.graphics.draw
local gprint = love.graphics.print
local setFont = love.graphics.setFont

local _rnd = math.random

gui = {}

function gui:create()
  local _i = {}
  setmetatable(_i, {__index = self})
  _i:reset()
  return _i
end
function gui:reset()
  self.controls = {}
  self.tabindex = 1
  self.tabcount = 0
  self.usingmouse = false
end

function gui:add(v)
  v = v or {}
  v.id = v.id or "g" .. _rnd(100000,999999)
  v.type = v.type or "button"
  print(v.type)
  local t = v.type
  local n = #self.controls + 1
  if t == "button" then
    self.controls[n] = control.button:new(v)
  end

  table.sort(self.controls, function(a, b) return a.sy < b.sy end )
  for i = 1, #self.controls do
    self.controls[i].tabindex = i
  end
  self.tabcount = #self.controls

  return v.id
end

function gui:update(dt)
  for i, g in pairs(self.controls) do
    g:update(dt, self)
  end
end

function gui:draw()
  for i, g in pairs(self.controls) do
    local selected = false
    if i == self.tabindex then
      selected = true
    end
    g:draw(selected)
  end
end

function gui:clear()
  self.controls = {}
end

function gui:next()
  self.tabindex = self.tabindex + 1
  if self.tabindex > self.tabcount then self.tabindex = 1 end
end

function gui:previous()
  self.tabindex = self.tabindex - 1
  if self.tabindex < 1 then self.tabindex = self.tabcount end
end

function gui:keyboard(k)
  self.usingmouse = false
  if k == "up" or (k == "tab" and (keyboard.isDown("rshift") or keyboard.isDown("lshift"))) then
    self:previous()
  elseif k == "down" or k == "tab" then
    self:next()
  elseif k == "left" then
    if self.controls[self.tabindex].cangolr then
      self:previous()
    else

    end
  elseif k == "right" then
    if self.controls[self.tabindex].cangolr then
      self:next()
    else

    end
  elseif k == "return" or k == "space" then
    self.controls[self.tabindex].click()
  end
end


control = { button = {}, slider = {} }


--A normal button. Clickable. Press Enter/Return. Attach functions.
function control.button:new(v)
  local _i = {}
  setmetatable(_i, {__index = self})
  _i:reset(v)
  return _i
end
function control.button:reset(v)
  self.x = v.x or 0
  self.y = v.y or 0
  self.w = v.w or 0
  self.h = v.h or 0
  self.id = v.id
  self.title = v.title or ""
  self.font = v.font or font["dialog"]
  self.tabindex = -1
  self.click = v.click or function() print("This button does nothing") end
  self.mousedown = false
  self.focus = false
  self.type = v.type
  self.cangolr = true

  self.sy = self.y + (self.x / 1000)
  self.titleY = (self.h - self.font:getHeight()) / 2+ 5
  self.titleX = (self.w - self.font:getWidth(self.title)) / 2
end
function control.button:update(dt, gui)
  if overlap(m.x, m.y, 1, 1, self.x, self.y, self.w, self.h) then
    gui.usingmouse = true
    gui.tabindex = i
    if self.mousedown == false and mouse.isDown("l") then
      self.mousedown = true
      print("Mouse Down")
    end
  end
  if self.mousedown == true and mouse.isDown("l") == false then
    if overlap(m.x, m.y, 1, 1, self.x, self.y, self.w, self.h) then
      self.mousedown = false
      print("Mouse Up")
      self.click()
    else
      self.mousedown = false
      print("Mouse Up (Out)")
    end
  end
end
function control.button:draw(selected)
  if self.type == "button" then
    color(0,0,0)
    if selected then
      color(255,0,0)
    end
    rectangle("fill", self.x, self.y, self.w, self.h)
    setFont(self.font)
    color(255,255,255)
    gprint(self.title, self.x + self.titleX, self.y + self.titleY)
    setFont(font["tiny"])
    gprint(self.tabindex, self.x + 1, self.y + 1)
  end
end
