local dw = director.displayWidth
local dh = director.displayHeight

-- Load the saved JSON string back
file = io.open("linux.json", "r")
dbg.assert(file, "Failed to open file for reading")
encoded = file:read("*a")
file:close()

-- Convert the string back to Lua table
questions = json.decode(encoded)
--dbg.printTable(questions) -- seriously, this works as expected already
num = 1

local background = director:createRectangle( {
    x=dw/2, y=dh/2, -- center in center of screen
    w=dw, h=dh,
    color=color.white
    } )
local arial = director:createFont("Arial18.fnt")


labels = {}
backgrounds = {}
-- Not too sure about the layout - it seems to calculate the height needed to show the text, then creates the box, not the other way around
if dw > dh then
    question = director:createLabel( {
        x = 0, y = dh - 16,
        } )
    labels[1] = director:createLabel( {
        x=dw*2/4, y=(dh*3/3)-16,
        font = arial,
        } )
    labels[2] = director:createLabel( {
        x=dw*2/4, y=(dh*2/3)-16,
        font = arial,
        } )
    labels[3] = director:createLabel( {
        x=dw*2/4, y=(dh*1/3)-16,
        font = arial,
        } )
    backgrounds[1] = director:createLabel( {
        x=dw*3/4, y=(dh*5/6), w = dw*2/4, h = (dh*1/3),
        name = "1.01"
        } )
    backgrounds[2] = director:createLabel( {
        x=dw*3/4, y=(dh*3/6), w = dw*2/4, h = (dh*1/3),
        name = "1.02"
        } )
    backgrounds[3] = director:createLabel( {
        x=dw*3/4, y=(dh*1/6), w = dw*2/4, h = (dh*1/3),
        name = "1.03"
        } )
else
    dbg.print("taller than wide")
    question = director:createLabel( {
        x = 0, y = dh - 16,
        } )
    labels[1] = director:createLabel( {
        x=dw*2/4, y=(dh*3/3)-16,
        font = arial,
        name = "1"
        } )
    labels[2] = director:createLabel( {
        x=dw*2/4, y=(dh*2/3)-16,
        font = arial,
        name = "2"
        } )
    labels[3] = director:createLabel( {
        x=dw*2/4, y=(dh*1/3)-16,
        font = arial,
        name = "3"
        } )
    backgrounds[1] = director:createRectangle( {
        x=dw*3/4, y=(dh*5/6), w = dw*2/4, h = (dh*1/3),
        name = "1.01"
        } )
    backgrounds[2] = director:createRectangle( {
        x=dw*3/4, y=(dh*3/6), w = dw*2/4, h = (dh*1/3),
        name = "1.02"
        } )
    backgrounds[3] = director:createRectangle( {
        x=dw*3/4, y=(dh*1/6), w = dw*2/4, h = (dh*1/3),
        name = "1.03"
        } )
end

-- Set options for the question label
question.font = arial
question.hAlignment = "middle"
question.vAlignment = "middle"
question.wrapWidth = dw*2/4
question.color = color.black

-- Do stuff to the labels
for i=1,3,1 do
    labels[i].hAlignment = "left"
    labels[i].vAlignment = "middle"
    labels[i].wrapWidth = dw*2/4
    labels[i].color = color.black
end

-- Do stuff to the background rectangles
for i=1,3,1 do
    backgrounds[i].color = color.green
    backgrounds[i].alpha = 0.5
end

function questions.switchLabels()
    if num == #questions then
        director:setCurrentScene(nil)
        director:moveToScene(endScreen)
    else
        for i=1,3,1  do
            labels[i].text = questions[num]["label"..i]
        end
        question.text = questions[num]["question"]
        num = num + 1
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
        backgrounds[ans].alpha = 0.5
    end
end


-- Functional-ize it, using the node name. I hope self.name works...
function touch(event)
    if event.phase == "began" then
        questions.validate(math.floor(tonumber(system:getFocus().name)))
    end
end

for i=1,3,1  do
    labels[i]:addEventListener("touch", touch)
    backgrounds[i]:addEventListener("touch", touch)
end

questions.switchLabels()
