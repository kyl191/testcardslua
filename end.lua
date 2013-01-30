local scene = director:createScene()
scene.name = "End screen"

local dw = director.displayWidth
local dh = director.displayHeight
local arial = director:createFont("Arial32.fnt")
local obj0 = director:createLabel( {
        x=10, y=dh/2,
        font = arial,
        w = dw - 20,
        hAlignment = "middle", vAlignment = "middle",
        color = color.black,
        text = "Congratulations on finishing. Tap anywhere to restart."
        } )
local obj1 = director:createRectangle( {
        x=dw/2, y=dh/2, w=dw, h=dh,
        color=color.white, zOrder=-1,
    } )

function scene:setUp(event)
    dbg.print("endscene hit!")
end
function scene:tearDown(event)
    dbg.print("scene1:tearDown")
    obj0 = nil
    obj1 = nil
end

function touch(event)
    if event.phase == "began" then
        director:setCurrentScene(nil)
        director:moveToScene(questionsScreen)
    end
end

obj0:addEventListener("touch", touch)
obj1:addEventListener("touch", touch)

scene:addEventListener( { "setUp", "tearDown" }, scene)

return scene
