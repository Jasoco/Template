local graphics = love.graphics
local timer = love.timer
local mouse = love.mouse
local keyboard = love.keyboard

local _flr = math.floor
local _max = math.max
local _min = math.min

math.randomseed(os.time())

--Load all library LUA files
local fl = love.filesystem.enumerate("lib/")
for i, f in pairs(fl) do
  local ext = string.sub(f, -4)
  if ext == ".lua" then
    require("lib/"..f)
  end
end

function love.run()
	love.load(arg)

	while true do
	  fps = timer.getFPS()
	  local dt = timer.getDelta()
		timer.step()
		time = timer.getTime()
    graphics.clear()
    love.update(dt)
    love.draw(dt)
    for e,a,b,c in love.event.poll() do
      if e == "q" then
        if love.audio then love.audio.stop() end
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

  _gui = gui:create()
  _gui:add({x = 40, y = 70, w = 100, h = 20, title = "Title 2"})
  _gui:add({x = 180, y = 40, w = 100, h = 20, title = "Title 3"})
  _gui:add({x = 40, y = 40, w = 100, h = 20, title = "Title 1"})
  _gui:add({x = 180, y = 70, w = 100, h = 20, title = "Title 4"})

  screen = displaySettings:setup({w = 320, h = 200, scale = 2})
  screen:setMode(screen.ws)

  hasBuffers, result = pcall(createBuffers)

  m = {}

  graphics.setLineWidth(1)

  rt = rich.new{"{tiny}{black}Hello, {red}wor{green}ld{black}!", 200, black = {0, 0, 0}, green = {0, 255, 0}, big = font["dialog"], mono = font["mono16"], tiny = font["tiny"], red = {255, 0, 0}}
end

function love.update(dt)
  _dbg:update(dt, fps)

  m.x = _min(_max(_flr((mouse.getX() - screen.ox) / screen.s),0),screen.w-1)
  m.y = _min(_max(_flr((mouse.getY() - screen.oy) / screen.s),0),screen.h-1)

  local kSpace = keyboard.isDown(" ")
  local kLeft = keyboard.isDown("left")
  local kRight = keyboard.isDown("right")
  local kUp = keyboard.isDown("up")
  local kDown = keyboard.isDown("down")
  local kShift = keyboard.isDown("lshift") or keyboard.isDown("rshift")

  if kLeft and kRight == false then

  elseif kRight and kLeft == false then

  elseif kLeft == false and kRight == false then

  end

  if kUp and kDown == false then

  elseif kDown and kUp == false then

  elseif kUp == false and kDown == false then

  end

  _gui:update()

end

function love.draw()
  screen:prepare()

  _gui:draw()

  _dbg:draw(dt)

  rt:draw(100, 0)

  screen:draw()
  screen:matte()
end

function love.mousepressed(x, y, button)
  if button == "l" then
    mouse.setGrab(true)

  elseif button == "r" then

  elseif button == "m" then

  elseif button == "wu" then

  elseif button == "wd" then

  end
end

function love.keypressed(k)
  if k == " " then

  end

  if k == "escape" then
    mouse.setGrab(not mouse.isGrabbed())
  end

  if k == "=" then
    if keyboard.isDown("lalt") then
      screen:setFloorScale(not screen:getFloorScale())
      screen:updateScale()
    else
      screen:switchRes()
    end
  end

  if k == _dbg.key then
    _dbg:toggle()
  end

  _gui:keyboard(k)
end

function love.focus(f)
  mouse.setGrab(f)
end
