--[[
 __     __        ___   ___   ___     _____ _             _ _       
 \ \   / /       / _ \ / _ \ / _ \   / ____| |           | (_)      
  \ \_/ /_ _ _ _| (_) | (_) | | | | | (___ | |_ _   _  __| |_  ___  
   \   / _` | '__> _ < \__, | | | |  \___ \| __| | | |/ _` | |/ _ \ 
    | | (_| | | | (_) |  / /| |_| |  ____) | |_| |_| | (_| | | (_) |
    |_|\__,_|_|  \___/  /_/  \___/  |_____/ \__|\__,_|\__,_|_|\___/ 
   	
	This script was made by the Roblox user Yar890.
	
	Module Name: KartAPI
	Last Updated: 08/02/2021
	Purpose: API for kart inbound and outbound
--]]

----------------------------------------- Variables -----------------------------------------
-- Module
local KartAPI = {}

-- Kart Inbound/Outbound
mKart = game.ServerScriptService:WaitForChild("Yar890Studio"):WaitForChild("Racing"):WaitForChild("Kart");
mKartInbound = mKart:WaitForChild("Inbound");
mKartOutbound = mKart:WaitForChild("Outbound");

------------------------------------------ Methods ------------------------------------------

--[[
	Function Name: KartAPI.AddKart
	Parameter: Object
	Return: Nil
	
	Purpose: Adds kart to controller
--]]
function KartAPI.AddKart(pKartModel)
	mKartInbound:WaitForChild("AddKart"):Fire(pKartModel);
end



--[[
	Function Name: KartAPI.DeleteKart
	Parameter: String
	Return: Nil
	
	Purpose: Deletes kart with matches "pKartId". If nil, then delete all karts
--]]
function KartAPI.DeleteKart(pKartId)
	mKartInbound:WaitForChild("DeleteKart"):Fire(pKartId);
end



--[[
	Function Name: KartAPI.UpdateMaxSpeed
	Parameter: String, Int
	Return: Nil
	
	Purpose: Updates max speed for karts matching "pKartId". If "pKartId" is nil, update max speed of all karts to "pNewSpeed"
--]]
function KartAPI.UpdateMaxSpeed(pKartId, pNewSpeed)
	mKartInbound:WaitForChild("UpdateMaxSpeed"):Fire(pKartId, pNewSpeed);
end



--[[
	Function Name: KartAPI.GetKartAddedEvent
	Parameter: Nil
	Return: BindableEvent
	
	Purpose: Returns GetKartAddedEvent bindable event. To get kart model, you can do KartModule.KartModel.
		Event returns the following:
		KartModule: Instance of kart added. Contains kart model, player, max speed etc.
--]]
function KartAPI.GetKartAddedEvent()
	return mKartOutbound:WaitForChild("KartAdded");
end



--[[
	Function Name: KartAPI.PlayerAddedToKart
	Parameter: Nil
	Return: BindableEvent
	
	Purpose: Returns PlayerAddedToKart bindable event. To get kart model, you can do KartModule.KartModel.
		Event returns the following:
		Player: The player who sat in kart seat
		KartModule: Instance of kart which player has sat in. Contains kart model, player, max speed etc.
--]]
function KartAPI.GetPlayerAddedToKartEvent()
	return mKartOutbound:WaitForChild("PlayerAddedToKart");
end



--[[
	Function Name: KartAPI.PlayerRemovedFromKart
	Parameter: Nil
	Return: BindableEvent
	
	Purpose: Returns PlayerRemovedFromKart bindable event. To get kart model, you can do KartModule.KartModel.
		Event returns the following:
		Player - The player who left kart seat
		KartModule -  Instance of kart which player had left seat. Contains kart model, player, max speed etc.
--]]
function KartAPI.GetPlayerRemovedFromKartEvent()
	return mKartOutbound:WaitForChild("PlayerRemovedFromKart");
end

return KartAPI
