--[[

	This script was made by AstrophsicaDev
	
	Module Name: SafetyLightsAPI
	Last Updated: 08/02/2021
	Purpose: API for safety lights inbound and outbound
--]]

----------------------------------------- Variables -----------------------------------------
-- Module
local SafetyLightsAPI = {}

-- RacingLights Inbound/Outbound
mSafetyLights = game.ServerScriptService:WaitForChild("Yar890Studio"):WaitForChild("Racing"):WaitForChild("SafetyLights")
mSafetyLightsInbound = mSafetyLights:WaitForChild("Inbound");
mSafetyLightsOutbound = mSafetyLights:WaitForChild("Outbound");

------------------------------------------ Methods ------------------------------------------

--[[
	Function Name: SafetyLightsAPI.AddControlPanel
	Parameter: Object
	Return: Nil
	
	Purpose: Adds control panel to controller
--]]
function SafetyLightsAPI.AddControlPanel(pControlPanelModel)
	mSafetyLightsInbound:WaitForChild("AddControlPanel"):Fire(pControlPanelModel);
end



--[[
	Function Name: CollisionAPI.DeleteControlPanel
	Parameter: Object
	Return: Nil
	
	Purpose: Delete control panel based on model
--]]
function SafetyLightsAPI.DeleteControlPanel(pControlPanelModel)
	mSafetyLightsInbound:WaitForChild("DeleteControlPanel"):Fire(pControlPanelModel);
end



--[[
	Function Name: SafetyLightsAPI.AddSafetyLight
	Parameter: Object
	Return: Nil
	
	Purpose: Adds safety lights to controller
--]]
function SafetyLightsAPI.AddSafetyLight(pSafetyLightModel)
	mSafetyLightsInbound:WaitForChild("AddSafetyLight"):Fire(pSafetyLightModel);
end



--[[
	Function Name: SafetyLightsAPI.DeleteSafetyLight
	Parameter: Object
	Return: Nil
	
	Purpose: Delete safety light based on model
--]]
function SafetyLightsAPI.DeleteSafetyLight(pControlPanelModel)
	mSafetyLightsInbound:WaitForChild("DeleteSafetyLight"):Fire(pControlPanelModel);
end



--[[
	Function Name: SafetyLightsAPI.UpdateLight
	Parameter: String
	Return: Nil
	
	Purpose: Updates racing lights based on pLightColorString. pLightColorString should be "Green", "Yellow" or "Red" only
--]]
function SafetyLightsAPI.UpdateLight(pLightColorString)
	mSafetyLightsInbound:WaitForChild("UpdateLight"):Fire(pLightColorString);
end



--[[
	Function Name: SafetyLightsAPI.GetLightChangedEvent
	Parameter: Nil
	Return: BindableEvent
	
	Purpose: Returns LightChanged bindable event.
		Event returns the following:
		Player - The player who triggered light change event
		LightString - Color of new light (can only be "Green", "Yellow" or "Red)
		NewKartMaxSpeed- New max speed for all karts
--]]
function SafetyLightsAPI.GetLightChangedEvent()
	return mSafetyLightsOutbound:WaitForChild("LightChanged");
end


return SafetyLightsAPI