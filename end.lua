local scene = director:createScene()
scene.name = "End screen"

local dw = director.displayWidth
local dh = director.displayHeight
function scene:setUp(event)
	dbg.print("endscene")
	self.obj0 = director:createLabel(4, dh/2, "MAIN MENU")
	self.obj1 = director:createRectangle( {
		x=dw/2, y=dh/2, w=dw, h=dh,
		color=color.red, zOrder=-1,
	} )
end
function scene:tearDown(event)
	dbg.print("scene1:tearDown")
	self.obj0 = nil
	self.obj1 = nil
end

scene:addEventListener( { "setUp", "tearDown" }, scene)

return scene
