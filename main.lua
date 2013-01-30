local questionsScreen = dofile("questions.lua")
local endScreen = dofile("end.lua")
    
-- Load the saved JSON string back
file = io.open("linux.json", "r")
dbg.assert(file, "Failed to open file for reading")
encoded = file:read("*a")
file:close()

-- Convert the string back to Lua table
questions = json.decode(encoded)
dbg.printTable(questions)
num = 1

director:setCurrentScene(nil)
director:moveToScene(questionsScreen)