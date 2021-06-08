--[[
 __     __        ___   ___   ___     _____ _             _ _       
 \ \   / /       / _ \ / _ \ / _ \   / ____| |           | (_)      
  \ \_/ /_ _ _ _| (_) | (_) | | | | | (___ | |_ _   _  __| |_  ___  
   \   / _` | '__> _ < \__, | | | |  \___ \| __| | | |/ _` | |/ _ \ 
    | | (_| | | | (_) |  / /| |_| |  ____) | |_| |_| | (_| | | (_) |
    |_|\__,_|_|  \___/  /_/  \___/  |_____/ \__|\__,_|\__,_|_|\___/ 
   	
	This script was made by the Roblox user Yar890.
	
	Module Name: Example
	Last Updated: 08/02/2021
	Purpose: Example script showing how to interact with API events
--]]

------------------------------------------ Barrier API ------------------------------------------
local barrierAPI = require(script.Parent.BarrierAPI)

barrierAPI.GetBarrierToggledEvent().Event:Connect(function(classId, status)
	print("Barriers with class ID '" .. classId .. "' has its status changed to: " .. tostring(status));
end)

------------------------------------------ Collision API ------------------------------------------
local collisionAPI = require(script.Parent.CollisionAPI)

collisionAPI.GetCollisionToggledEvent().Event:Connect(function(status)
	print("Collision status is now: " .. tostring(status))
end)

------------------------------------------ Kart API ------------------------------------------
local kartAPI = require(script.Parent.KartAPI)

kartAPI.GetKartAddedEvent().Event:Connect(function(kart)
	print("New kart added to game: " .. kart.KartModel.Name);
end)

kartAPI.GetPlayerAddedToKartEvent().Event:Connect(function(player, kart)
	print(player.Name .. " has sat in kart: " .. kart.KartModel.Name);
end)

kartAPI.GetPlayerRemovedFromKartEvent().Event:Connect(function(player, kart)
	print(player.Name .. " has left kart seat: " .. kart.KartModel.Name);
end)

------------------------------------------ KartSpawn API ------------------------------------------
local kartSpawnApi = require(script.Parent.KartSpawnAPI)

kartSpawnApi.GetKartSpawnedEvent().Event:Connect(function(player)
	print(player.Name .. " has spawned in karts");
end)

------------------------------------------ RacingLights API ------------------------------------------
local safetyLightsApi = require(script.Parent.SafetyLightsAPI)

safetyLightsApi.GetLightChangedEvent().Event:Connect(function(player, lightString, newMaxSpeed)
	print(player.Name .. " has triggered light change event. New light status is '" .. lightString .. "' and new max speed is " .. newMaxSpeed);
end)

------------------------------------------ StartingLights API ------------------------------------------
local startingLightsAPI = require(script.Parent.StartingLightsAPI)

startingLightsAPI.GetStatusToggledEvent().Event:Connect(function(status)
	print("Current starting light status is: " .. status)
end)