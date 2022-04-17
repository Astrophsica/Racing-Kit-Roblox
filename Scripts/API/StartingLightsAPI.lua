--[[

	This script was made by AstrophsicaDev
	
	Module Name: StartingLightsAPI
	Purpose: API for starting lights inbound and outbound
--]]

----------------------------------------- Variables -----------------------------------------
-- Module
local StartingLightsAPI = {}

-- StartingLights Inbound/Outbound
mStartingLight = game.ServerScriptService:WaitForChild("Yar890Studio"):WaitForChild("Racing"):WaitForChild("StartingLights")
mStartingLightsInbound = mStartingLight:WaitForChild("Inbound");
mStartingLightsOutbound = mStartingLight:WaitForChild("Outbound");

------------------------------------------ Methods ------------------------------------------

--[[
	Function Name: StartingLightsAPI.AddControlPanel
	Parameter: Object
	Return: Nil
	
	Purpose: Adds control panel to controller
--]]
function StartingLightsAPI.AddControlPanel(pControlPanelModel)
	mStartingLightsInbound:WaitForChild("AddControlPanel"):Fire(pControlPanelModel);
end



--[[
	Function Name: StartingLightsAPI.DeleteControlPanel
	Parameter: Object
	Return: Nil
	
	Purpose: Delete control panel based on model
--]]
function StartingLightsAPI.DeleteControlPanel(pControlPanelModel)
	mStartingLightsInbound:WaitForChild("DeleteControlPanel"):Fire(pControlPanelModel);
end



--[[
	Function Name: StartingLightsAPI.AddStartingLight
	Parameter: Object
	Return: Nil
	
	Purpose: Adds starting lights to controller
--]]
function StartingLightsAPI.AddStartingLight(pStartingLightModel)
	mStartingLightsInbound:WaitForChild("AddStartingLight"):Fire(pStartingLightModel);
end



--[[
	Function Name: StartingLightsAPI.DeleteStartingLight
	Parameter: Object
	Return: Nil
	
	Purpose: Delete starting light based on model
--]]
function StartingLightsAPI.DeleteStartingLight(pStartingLightModel)
	mStartingLightsInbound:WaitForChild("DeleteStartingLight"):Fire(pStartingLightModel);
end



--[[
	Function Name: StartingLightsAPI.ToggleStatus
	Parameter: Nil
	Return: Nil
	
	Purpose: Toggles starting lights go/stop
--]]
function StartingLightsAPI.ToggleStatus()
	mStartingLightsInbound:WaitForChild("ToggleStatus"):Fire();
end



--[[
	Function Name: StartingLightsAPI.GetStatusToggledEvent
	Parameter: Nil
	Return: BindableEvent
	
	Purpose: Returns StatusToggled bindable event.
		Event returns the following:
		Status - Represents current status of lights (can only be "Red", "Blink" or "Green")
--]]
function StartingLightsAPI.GetStatusToggledEvent()
	return mStartingLightsOutbound:WaitForChild("StatusToggled");
end

return StartingLightsAPI
