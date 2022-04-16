--[[
 __     __        ___   ___   ___     _____ _             _ _       
 \ \   / /       / _ \ / _ \ / _ \   / ____| |           | (_)      
  \ \_/ /_ _ _ _| (_) | (_) | | | | | (___ | |_ _   _  __| |_  ___  
   \   / _` | '__> _ < \__, | | | |  \___ \| __| | | |/ _` | |/ _ \ 
    | | (_| | | | (_) |  / /| |_| |  ____) | |_| |_| | (_| | | (_) |
    |_|\__,_|_|  \___/  /_/  \___/  |_____/ \__|\__,_|\__,_|_|\___/ 
   	
	This script was made by the Roblox user Yar890.
	
	Module Name: TrackChangeAPI
	Last Updated: 27/02/2021
	Purpose: API for track change inbound and outbound
--]]

----------------------------------------- Variables -----------------------------------------
-- Module
local TrackChangeAPI = {}

-- TrackChange Inbound/Outbound
mTrackChange = game.ServerScriptService:WaitForChild("Yar890Studio"):WaitForChild("Racing"):WaitForChild("TrackChange");
mTrackChangeInbound = mTrackChange:WaitForChild("Inbound");
mTrackChangeOutbound = mTrackChange:WaitForChild("Outbound");

------------------------------------------ Methods ------------------------------------------

--[[
	Function Name: TrackChangeAPI.AddControlPanel
	Parameter: Object
	Return: Nil
	
	Purpose: Adds control panel to controller
--]]
function TrackChangeAPI.AddControlPanel(pControlPanelModel)
	mTrackChangeInbound:WaitForChild("AddControlPanel"):Fire(pControlPanelModel);
end



--[[
	Function Name: TrackChangeAPI.DeleteControlPanel
	Parameter: Object
	Return: Nil
	
	Purpose: Delete control panel based on model
--]]
function TrackChangeAPI.DeleteControlPanel(pControlPanelModel)
	mTrackChangeInbound:WaitForChild("DeleteControlPanel"):Fire(pControlPanelModel);
end



--[[
	Function Name: TrackChangeAPI.ToggleTrackChange
	Parameter: Nil
	Return: Nil
	
	Purpose: Toggles track change
--]]
function TrackChangeAPI.ToggleCollision()
	mTrackChangeInbound:WaitForChild("ToggleTrackChange"):Fire();
end


return TrackChangeAPI

