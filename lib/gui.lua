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
  local guiInstance = {}
  setmetatable(guiInstance, {__index = self})
  guiInstance:reset()
  return guiInstance
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
    if overlap(m.x, m.y, 1, 1, g.x, g.y, g.w, g.h) then
      self.usingmouse = true
      self.tabindex = i
      if g.mousedown == false and mouse.isDown("l") then
        g.mousedown = true
        print("Mouse Down")
      end
    end
    if g.mousedown == true and mouse.isDown("l") == false then
      if overlap(m.x, m.y, 1, 1, g.x, g.y, g.w, g.h) then
        g.mousedown = false
        print("Mouse Up")
        g.click()
      else
        g.mousedown = false
        print("Mouse Up (Out)")
      end
    end
  end
end

function gui:draw()
  for i, g in pairs(self.controls) do
    if g.type == "button" then
      color(0,0,0)
      if i == self.tabindex then
        color(255,0,0)
      end
      rectangle("fill", g.x, g.y, g.w, g.h)
      setFont(g.font)
      color(255,255,255)
      gprint(g.title, g.x + g.titleX, g.y + g.titleY)
      setFont(font["tiny"])
      gprint(g.tabindex, g.x + 1, g.y + 1)
    end
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

function control.button:new(v)
  local guiInstance = {}
  setmetatable(guiInstance, {__index = self})
  guiInstance:reset(v)
  return guiInstance
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
