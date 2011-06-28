local graphics = love.graphics
local timer = love.timer
local mouse = love.mouse
local keyboard = love.keyboard
local keyDown = keyboard.isDown

local gprint = love.graphics.print

local _flr = math.floor
local _max = math.max
local _min = math.min
local _rnd = math.random

math.randomseed(os.time())

--Load all library LUA files
local fl = love.filesystem.enumerate("lib/")
for i, f in pairs(fl) do
  local ext = string.sub(f, -4)
  if ext == ".lua" then
    require("lib/"..f)
  end
end

local fl = love.filesystem.enumerate("game/")
for i, f in pairs(fl) do
  local ext = string.sub(f, -4)
  if ext == ".lua" then
    require("game/"..f)
  end
end

function love.run()
	love.load(arg)

	while true do
	  fps = timer.getFPS()
	  dt = timer.getDelta()
		timer.step()
		time = timer.getTime()
    graphics.clear()
    love.update()
    love.draw()
    for e,a,b,c in love.event.poll() do
      if e == "q" then
        if love.audio then love.audio.stop() end
        graphics.setMode(320, 200, false, false)
      return
      end
      love.handlers[e](a,b,c)
    end
		timer.sleep(1)
		graphics.present()
	end
end

function love.load()
  _dbg = debugger:init()

  screen = displaySettings:setup({w = 320, h = 200, scale = 2})
  screen:setMode(screen.ws)

  hasBuffers, result = pcall(createBuffers)

  m = {}

  graphics.setLineWidth(1)

  --rt = rich.new{"{tiny}{black}Hello, {red}wor{green}ld{black}!", 200, black = {0, 0, 0}, green = {0, 255, 0}, big = font["dialog"], mono = font["mono16"], tiny = font["tiny"], red = {255, 0, 0}}

  game = newGame:init()
end

function love.update()
  _dbg:update()
  game:update()
end

function love.draw()
  screen:prepare()

  _dbg:draw()

  --rt:draw(100, 0)

  game:draw()

  screen:draw()
  screen:matte()
end

function love.mousepressed(x, y, button)
  game:mousePressed(x, y, button)
  if button == "l" then
    mouse.setGrab(true)

  elseif button == "r" then

  elseif button == "m" then

  elseif button == "wu" then

  elseif button == "wd" then

  end
end

function love.keypressed(k)
  game:keyPressed(k)

  if k == " " then

  end

  if k == "escape" then
    mouse.setGrab(not mouse.isGrabbed())
  end

  if k == "r" and keyDown("lmeta") then
    love.load(arg)
  end

  if k == "s" then
    screen:setSmooth(not screen:getSmooth())
    hasBuffers, result = pcall(createBuffers)
  end

  if k == "=" then
    if keyboard.isDown("lalt") then
      screen:setFloorScale(not screen:getFloorScale())
      screen:updateScale()
    else
      screen:switchRes()
      hasBuffers, result = pcall(createBuffers)
    end
  end

  if k == _dbg.key then
    _dbg:toggle()
  end
end

function love.focus(f)
  mouse.setGrab(f)
end
