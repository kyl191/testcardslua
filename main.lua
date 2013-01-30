local questionsScreen = dofile("questions.lua")
local endScreen = dofile("end.lua")

director:setCurrentScene(nil)
director:moveToScene(questionsScreen)