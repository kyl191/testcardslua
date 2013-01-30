local dw = director.displayWidth
local dh = director.displayHeight

local background = director:createRectangle( {
    x=dw/2, y=dh/2, -- center in center of screen
    w=dw, h=dh,
    color=color.white
    } )
local arial = director:createFont("Arial18.fnt")


labels = {}
-- Not too sure about the layout - it seems to calculate the height needed to show the text, then creates the box, not the other way around
-- LABEL JUSTIFICATION!
if dw > dh then
    question = director:createLabel( {
    x = 0, y = dh - 16,
    font = arial, 
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
        x=dw*2/4, y=(dh*0/3)-16,
        font = arial,
        wrapWidth=dw*2/4,
        hAlignment = "left", vAlignment = "middle",
        color = color.black
        } )
    

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
