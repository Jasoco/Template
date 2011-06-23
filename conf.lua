function love.conf(t)
  t.author = "Jason Anderson"
	t.title = "One Dozen (12) Blank Robots"
	t.screen.width = 320*2
	t.screen.height = 200*2
	t.screen.vsync = true
	t.screen.fullscreen = false
  t.modules.joystick = false
  t.modules.audio = false
  t.modules.keyboard = true
  t.modules.event = true
  t.modules.image = true
  t.modules.graphics = true
  t.modules.timer = true
  t.modules.mouse = true
  t.modules.sound = false
  t.modules.physics = true
  t.console = false
end
