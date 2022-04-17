--[[

	This script was made by AstrophsicaDev
	
	Module Name: KartSpawnAPI
	Purpose: API for kart spawn inbound and outbound
--]]

----------------------------------------- Variables -----------------------------------------
-- Module
local KartSpawnAPI = {}

-- KartSpawn Inbound/Outbound
mKartSpawn = game.ServerScriptService:WaitForChild("Yar890Studio"):WaitForChild("Racing"):WaitForChild("KartSpawn");
mKartSpawnInbound = mKartSpawn:WaitForChild("Inbound");
mKartSpawnOutbound = mKartSpawn:WaitForChild("Outbound");

------------------------------------------ Methods ------------------------------------------

--[[
	Function Name: KartSpawnAPI.AddControlPanel
	Parameter: Object
	Return: Nil
	
	Purpose: Adds control panel to controller
--]]
function KartSpawnAPI.AddControlPanel(pControlPanelModel)
	mKartSpawnInbound:WaitForChild("AddControlPanel"):Fire(pControlPanelModel);
end



--[[
	Function Name: KartSpawnAPI.GetKartSpawnedEvent
	Parameter: Nil
	Return: BindableEvent
	
	Purpose: Returns KartSpawned bindable event.
		Event returns the following:
		Player - The player who spawned the karts vis kart respawn button
--]]
function KartSpawnAPI.GetKartSpawnedEvent()
	return mKartSpawnOutbound:WaitForChild("KartSpawned");
end


return KartSpawnAPI