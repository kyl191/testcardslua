local dw = director.displayWidth
local dh = director.displayHeight

local r0 = director:createRectangle( {
    x=dw/2, y=dh/2, w=dw, h=dh,
    color=color.white
    } )
local arial = director:createFont("Arial18.fnt")
local question = director:createLabel( {
    x = 0, y = dh - 16,
    font = arial, 
    color=color.black
    } )

labels = {}
-- Not too sure about the layout - it seems to calculate the height needed to show the text, then creates the box, not the other way around
-- LABEL JUSTIFICATION!
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
    
-- Load the saved JSON string back
file = io.open("linux.json", "r")
dbg.assert(file, "Failed to open file for reading")
encoded = file:read("*a")
file:close()

-- Convert the string back to Lua table
questions = json.decode(encoded)
dbg.printTable(questions[1])
local num = 1
for i=1,3,1  do
    labels[i].text = questions[1]["label"..i]
end