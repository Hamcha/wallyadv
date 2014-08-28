-- Yep, this is just the hello world

function love.draw()
  love.graphics.print('WALLY.EXE TEST', 20, 20)
end

function love.keypressed(code)
  if code == 1 then os.exit() end
end