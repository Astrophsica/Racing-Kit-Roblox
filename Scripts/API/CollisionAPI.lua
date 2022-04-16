--[[

	This script was made by AstrophsicaDev
	
	Module Name: CollisionAPI
	Last Updated: 20/02/2021
	Purpose: API for collision inbound and outbound
--]]

----------------------------------------- Variables -----------------------------------------
-- Module
local CollisionAPI = {}

-- Collision Inbound/Outbound
mCollision = game.ServerScriptService:WaitForChild("Yar890Studio"):WaitForChild("Racing"):WaitForChild("Collision");
mCollisionInbound = mCollision:WaitForChild("Inbound");
mCollisionOutbound = mCollision:WaitForChild("Outbound");

------------------------------------------ Methods ------------------------------------------

--[[
	Function Name: CollisionAPI.AddControlPanel
	Parameter: Object
	Return: Nil
	
	Purpose: Adds control panel to controller
--]]
function CollisionAPI.AddControlPanel(pControlPanelModel)
	mCollisionInbound:WaitForChild("AddControlPanel"):Fire(pControlPanelModel);
end



--[[
	Function Name: CollisionAPI.DeleteControlPanel
	Parameter: Object
	Return: Nil
	
	Purpose: Delete control panel based on model
--]]
function CollisionAPI.DeleteControlPanel(pControlPanelModel)
	mCollisionInbound:WaitForChild("DeleteControlPanel"):Fire(pControlPanelModel);
end



--[[
	Function Name: CollisionAPI.ToggleCollision
	Parameter: Nil
	Return: Nil
	
	Purpose: Toggles kart collision on/off
--]]
function CollisionAPI.ToggleCollision()
	mCollisionInbound:WaitForChild("ToggleCollision"):Fire();
end



--[[
	Function Name: CollisionAPI.GetCollisionToggledEvent
	Parameter: Nil
	Return: BindableEvent
	
	Purpose: Returns CollisionToggled bindable event.
		Event returns the following:
		Status [bool] - Represents if collision is current on or off
--]]
function CollisionAPI.GetCollisionToggledEvent()
	return mCollisionOutbound:WaitForChild("CollisionToggled");
end


return CollisionAPI

