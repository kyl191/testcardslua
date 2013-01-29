local dw = director.displayWidth
local dh = director.displayHeight

-- Load the saved JSON string back
file = io.open(pathS .. "linux.json", "r")
dbg.assert(file, "Failed to open file for reading")
encoded = file:read("*a")
file:close()
dbg.print(encoded)

-- Convert the string back to Lua table
questions = json.decode(encoded)

-- Call our debug function to print table to console
dbg.printTable(questions)

local arial32 = director:createFont("fonts/Arial32.fnt")
local arial18 = director:createFont("fonts/Arial18.fnt")

local fontArial = director:createFont("fonts/Arial18.fnt")
local sprite3 = director:createLabel( {
    x=dw*2/4, y=dh*2/4,
    font = fontArial,
    text="My 3rd label",
    color={0xff, 0x80, 0x80},
    } )

function button:touch(event)
	if (event.phase == "began") then
		local r = math.random(0, 255)
		local g = math.random(0, 255)
		local b = math.random(0, 255)
		self:setColor(r, g, b)
	end
end
button:addEventListener("touch", button)

local x = 0
local y = 0
local dy = 20

-- Click on this text to play the music stream
local playStream = director:createLabel(x, y, "Play Stream")
function playStream:touch(event)
    if event.phase == "began" then
        audio:playStream("sound/Loop3.mp3", false)
    end
end
playStream:addEventListener("touch", playStream)
y = y + dy