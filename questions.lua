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
        font = arial,
        hAlignment = "left", vAlignment = "middle", 
        wrapWidth=dw*2/4,
        color=color.black
        } )
    labels[1] = director:createLabel( {
        x=dw*2/4, y=(dh*3/3)-16,
        font = arial,
        wrapWidth=dw*2/4,
        hAlignment = "left", vAlignment = "middle",
        color = color.black
        } )
    labels[2] = director:createLabel( {
        x=dw*2/4, y=(dh*2/3)-16,
        font = arial,
        wrapWidth=dw*2/4,
        hAlignment = "left", vAlignment = "middle",
        color = color.black
        } )
    labels[3] = director:createLabel( {
        x=dw*2/4, y=(dh*1/3)-16,
        font = arial,
        wrapWidth=dw*2/4,
        hAlignment = "left", vAlignment = "middle",
        color = color.black
        } )
    backgrounds[1] = director:createLabel( {
        x=dw*2/4, y=(dh*3/3)-16,
        color = color.green
        } )
    backgrounds[2] = director:createLabel( {
        x=dw*2/4, y=(dh*2/3)-16,
        color = color.green
        } )
    backgrounds[3] = director:createLabel( {
        x=dw*2/4, y=(dh*1/3)-16,
        color = color.green
        } )
else
    dbg.print("taller than wide")
    question = director:createLabel( {
        x = 0, y = dh - 16,
        font = arial, 
        hAlignment = "left", vAlignment = "middle", 
        wrapWidth=dw*2/4,
        color=color.black
        } )
    labels[1] = director:createLabel( {
        x=dw*2/4, y=(dh*3/3)-16,
        font = arial,
        wrapWidth=dw*2/4,
        hAlignment = "left", vAlignment = "middle",
        color = color.black
        } )
    labels[2] = director:createLabel( {
        x=dw*2/4, y=(dh*2/3)-16,
        font = arial,
        wrapWidth=dw*2/4,
        hAlignment = "left", vAlignment = "middle",
        color = color.black
        } )
    labels[3] = director:createLabel( {
        x=dw*2/4, y=(dh*1/3)-16,
        font = arial,
        wrapWidth=dw*2/4,
        hAlignment = "left", vAlignment = "middle",
        color = color.black
        } )
    backgrounds[1] = director:createRectangle( {
        x=dw*3/4, y=(dh*5/6), w = dw*2/4, h = (dh*1/3),
        color = color.green, alpha = 0.5
        } )
    backgrounds[2] = director:createRectangle( {
        x=dw*3/4, y=(dh*3/6), w = dw*2/4, h = (dh*1/3),
        color = color.green, alpha = 0.5
        } )
    backgrounds[3] = director:createRectangle( {
        x=dw*3/4, y=(dh*1/6), w = dw*2/4, h = (dh*1/3),
        color = color.green, alpha = 0.5
        } )
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
            labels[i].text = questions[num]["label"..i]
        end
        question.text = questions[num]["question"]
end
questions.switchLabels()
