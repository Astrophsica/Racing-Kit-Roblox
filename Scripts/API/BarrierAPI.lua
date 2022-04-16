--[[

	This script was made by AstrophsicaDev
	
	Module Name: BarrierAPI
	Last Updated: 08/02/2021
	Purpose: API for barrier inbound and outbound
--]]

----------------------------------------- Variables -----------------------------------------
-- Module
local BarrierAPI = {}

-- Barrier Inbound/Outbounds
mBarrier = game.ServerScriptService:WaitForChild("Yar890Studio"):WaitForChild("Racing"):WaitForChild("Barrier");
mBarrierInbound = mBarrier:WaitForChild("Inbound");
mBarrierOutbound = mBarrier:WaitForChild("Outbound");

------------------------------------------ Methods ------------------------------------------

--[[
	Function Name: BarrierAPI.AddBarrier
	Parameter: Object
	Return: Nil
	
	Purpose: Adds barrier to controller
--]]
function BarrierAPI.AddBarrier(pBarrierModel)
	mBarrierInbound:WaitForChild("AddBarrier"):Fire(pBarrierModel);
end



--[[
	Function Name: BarrierAPI.DeleteBarrier
	Parameter: Object
	Return: Nil
	
	Purpose: Delete barrier based on model
--]]
function BarrierAPI.DeleteBarrier(pBarrierModel)
	mBarrierInbound:WaitForChild("DeleteBarrier"):Fire(pBarrierModel);
end



--[[
	Function Name: BarrierAPI.AddControlPanel
	Parameter: Object
	Return: Nil
	
	Purpose: Adds control panel to controller
--]]
function BarrierAPI.AddControlPanel(pControlPanelModel)
	mBarrierInbound:WaitForChild("AddControlPanel"):Fire(pControlPanelModel);
end



--[[
	Function Name: BarrierAPI.DeleteControlPanel
	Parameter: Object
	Return: Nil
	
	Purpose: Delete control panel based on model
--]]
function BarrierAPI.DeleteControlPanel(pControlPanelModel)
	mBarrierInbound:WaitForChild("DeleteControlPanel"):Fire(pControlPanelModel);
end



--[[
	Function Name: BarrierAPI.ToggleBarrier
	Parameter: String
	Return: Nil
	
	Purpose: Toggles barrier on/off for barriers matching "pBarrierClassId"
--]]
function BarrierAPI.ToggleBarrier(pBarrierClassId)
	mBarrierInbound:WaitForChild("ToggleBarrier"):Fire(pBarrierClassId);
end



--[[
	Function Name: BarrierAPI.GetBarrierToggledEvent
	Parameter: String
	Return: BindableEvent
	
	Purpose: Returns BarrierToggled bindable event.
		Event returns the following:
		Class ID [string] - Represents which barrier class has been toggled.
		Status [bool] - Represents if barrier is open or closed.
--]]
function BarrierAPI.GetBarrierToggledEvent()
	return mBarrierOutbound:WaitForChild("BarrierToggled");
end


return BarrierAPI
