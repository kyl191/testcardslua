local questionsScreen = dofile("questions.lua")
local endScreen = dofile("end.lua")

local change = function(event)
    director:setCurrentScene(nil)
    if event.to == "q" then
        director:moveToScene(questionsScreen)
    elseif event.to == "e" then
        director:moveToScene(endScreen)
    end
end
system:addEventListener("tcdone", change)

system:sendEvent("tcdone", {to="q"})
