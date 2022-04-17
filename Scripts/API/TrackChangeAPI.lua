--[[

	This script was made by AstrophsicaDev
	
	Module Name: TrackChangeAPI
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

