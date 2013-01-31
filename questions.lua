local dw = director.displayWidth
local dh = director.displayHeight

-- Load the saved JSON string back
file = io.open("linux.json", "r")
dbg.assert(file, "Failed to open file for reading")
encoded = file:read("*a")
file:close()

-- Convert the string back to Lua table
questions = json.decode(encoded)

local background = director:createRectangle( {
    x=dw/2, y=dh/2, -- center in center of screen, seriously, displayed behaviour doesn't match the docs *at all*
    w=dw, h=dh,
    color=color.white
    } )
local arial = director:createFont("Arial18.fnt")


labels = {}
backgrounds = {}
-- Not too sure about the layout - it seems to calculate the height needed to show the text, then creates the box, not the other way around
if dw > dh then
    question = director:createLabel( {
        x = 5, y = dh - 5,
        w = (dw*2/4) - 10, h = dh - 10,
        font = arial,
        } )
    for i=0,2,1 do
        labels[i+1] = director:createLabel( {
            x = dw*2/4, y = (dh*(3-i)/3) - 16,
            w = dw * 1/2, h = (dh*1/3) - 16,
            font = arial,
        } )
        backgrounds[i+1] = director:createRectangle( {
            x = dw*3/4, y = (dh*(5-2*i)/6), w = dw*2/4, h = (dh*1/3),
        } )
    end
else
    question = director:createLabel( {
        x = 15, y = dh - 5,
        w = dw - 30, h = (dh*1/4) - 10,
        yAnchor = 1,
        font = arial,
    } )
    for i=0,2,1 do
        labels[i+1] = director:createLabel( {
            x = 15, y = (dh*(3-i)/4) - 5,
            w = dw - 30, h = (dh*1/4) - 10,
            font = arial,
            yAnchor = 1,
        } )
        backgrounds[i+1] = director:createRectangle( {
            x=dw*3/4, y=(dh*(5-2*i)/6), w = dw*2/4, h = (dh*1/3),
            yAnchor = 1,
        } )
    end
end

-- Set options for the question label
question.hAlignment = "left"
question.vAlignment = "top"
question.color = color.black
question.zOrder = 3

for i=1,3,1 do
    -- Do stuff to the labels
    labels[i].hAlignment = "left"
    labels[i].vAlignment = "top"
    labels[i].color = color.black
    labels[i].physics = nil
    labels[i].zOrder = 2
    
    -- Do stuff to the background rectangles
    backgrounds[i].color = color.white
    backgrounds[i].alpha = 0.5
    backgrounds[i].zOrder = 1
    backgrounds[i].physics = nil
end

num = 0
function questions.switchLabels()
    if num == #questions then
        system:removeEventListener("touch", touch)
        system:sendEvent("tcdone", {to="e"})
    else
        num = num + 1
        for i=1,3,1  do
            labels[i].text = questions[num]["label"..i]
        end
        question.text = questions[num]["question"]
    end
end

function questions.cleanAnswers()
        for i=1,3,1  do
            backgrounds[i].color = color.white
        end
end

function questions.validate(ans)
    if ans == questions[num]["answer"] then
        questions.cleanAnswers()
        questions.switchLabels()
    else
        backgrounds[ans].color = color.red
    end
end

function touch(event)
    if event.phase == "began" then
        for i=1,3,1 do
            if labels[i]:isPointInside(event.x, event.y) or backgrounds[i]:isPointInside(event.x, event.y) then
                questions.validate(i)
            end
        end
    end
end

system:addEventListener("touch", touch)

questions.switchLabels()
