local mouse = love.mouse
local printg = love.graphics.print
local setFont = love.graphics.setFont
local keyDown = love.keyboard.isDown

local _flr = math.floor
local _max = math.max
local _min = math.min

newGame = {}

function newGame:init(v)
  local _i = {}
  setmetatable(_i, {__index = self})
  _i:settings(v)
  return _i
end
function newGame:settings(v)
  v = v or {}
  self.timer = 0

  self.mode = "intro"

  self.game = gameInit:create()
  self.menu = menuInit:create()
  self.intro = introInit:create()
  self.options = optionsInit:create()
end

function newGame:update()
  kSpace = keyDown(" ")
  kLeft = keyDown("left")
  kRight = keyDown("right")
  kUp = keyDown("up")
  kDown = keyDown("down")
  kShift = keyDown("lshift") or keyDown("rshift")

  self.timer = self.timer + dt

  m.x = _min(_max(_flr((mouse.getX() - screen.ox) / screen.s),0),screen.w-1)
  m.y = _min(_max(_flr((mouse.getY() - screen.oy) / screen.s),0),screen.h-1)

  if game.mode == "intro" then
    self.intro:update()
  elseif game.mode == "menu" then
    self.menu:update()
  elseif game.mode == "game" then
    self.game:update()
  end
end
function newGame:draw()
  setFont(font["dialog"])
  printg(self.timer,10,170)
  printg(self.mode,10,185)

  if game.mode == "intro" then
    game.intro:draw()
  elseif game.mode == "menu" then
    game.menu:draw()
  elseif game.mode == "game" then
    game.game:draw()
  end
end
function newGame:keyPressed(k)
  if game.mode == "intro" then
    self.intro:keyPressed(k)
  elseif game.mode == "menu" then
    self.menu:keyPressed(k)
  elseif game.mode == "game" then
    self.game:keyPressed(k)
  end
end
function newGame:mousePressed(x, y, button)
  print("MOUSE:", x, y, button)
end

