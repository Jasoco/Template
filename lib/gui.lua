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
  local t = v.type
  local n = #self.controls + 1
  if t == "button" then
    self.controls[n] = control.button:new(v)
  elseif t == "toggle" then
    self.controls[n] = control.toggle:new(v)
  end

  table.sort(self.controls, function(a, b) return a.sy < b.sy end )
  for i = 1, #self.controls do
    self.controls[i].tabindex = i
  end
  self.tabcount = #self.controls

  return v.id
end
function gui:update()
  for i, c in pairs(self.controls) do
    c:update(self)

    if overlap(m.x, m.y, 1, 1, c.x, c.y, c.w, c.h) then
      self.usingmouse = true
      self.tabindex = c.tabindex
      if c.mousedown == false and mouse.isDown("l") then
        c.mousedown = true
        print("Mouse Down")
      end
    end
    if c.mousedown == true and mouse.isDown("l") == false then
      if overlap(m.x, m.y, 1, 1, c.x, c.y, c.w, c.h) then
        c.mousedown = false
        print("Mouse Up")
        c:activate()
      else
        c.mousedown = false
        print("Mouse Up (Out)")
      end
    end
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

function gui:keyPressed(k)
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
    self.controls[self.tabindex]:activate()
  end
end



control = {
  button = {},
  slider = {},
  toggle = {},
  textbox = {},
  listbox = {},
  textarea = {}
}

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
  self.click = v.click or function()
    print("This button does nothing") end
  self.mousedown = false
  self.focus = false
  self.type = "button"
  self.cangolr = true

  self.sy = self.y + (self.x / 1000)
  self.titleY = (self.h - self.font:getHeight()) / 2+ 5
  self.titleX = (self.w - self.font:getWidth(self.title)) / 2
end
function control.button:update(gui)

end
function control.button:draw(selected)
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
function control.button:activate()
  self.click()
end


--A toggle button/check box.
function control.toggle:new(v)
  local _i = {}
  setmetatable(_i, {__index = self})
  _i:reset(v)
  return _i
end
function control.toggle:reset(v)
  self.x = v.x or 0
  self.y = v.y or 0
  self.w = v.w or 0
  self.h = v.h or 0
  self.id = v.id
  self.values = v.values or {"Off", "On"}
  self.state = v.state or 1
  self.title = self.values[self.state]
  self.font = v.font or font["dialog"]
  self.tabindex = -1
  self.increment = self.increment or true
  self.click = v.click or function(s)
    print("The state of this button is now " .. self.values[s]) end
  self.mousedown = false
  self.focus = false
  self.type = "toggle"
  self.cangolr = true

  self.sy = self.y + (self.x / 1000)
  self.titleY = (self.h - self.font:getHeight()) / 2+ 5
  self.titleX = (self.w - self.font:getWidth(self.title)) / 2
end
function control.toggle:update(gui)

end
function control.toggle:draw(selected)
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
function control.toggle:activate()
  if self.increment then
    self.state = self.state + 1
    if self.state > #self.values then
      self.state = 1
    end
  end
  self.title = self.values[self.state]
  self.click(self.state)
end
